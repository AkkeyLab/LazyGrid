//
//  ContentView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

private enum Env {
    static let columnCount = 3
    static let vSpacing: CGFloat = 8
    static let hSpacing: CGFloat = 8
    static let topSpaceHeight: CGFloat = 80
    static let bottomSpaceHeight: CGFloat = 100
}

struct ContentView: View {
    @ObservedObject private var viewModel = SearchViewModel()
    @State private var showFavorite = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                PhotoCollectionView(data: $viewModel.interestingness, geometry: geometry)
                VStack(spacing: .zero) {
                    Rectangle()
                        .fill(Assets.background.color.toColor)
                        .edgesIgnoringSafeArea(.top)
                    loadTopSpace(width: geometry.size.width)
                    Spacer()
                        .layoutPriority(1)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $viewModel.alert.state) {
            viewModel.alert.alert
        }
    }

    private func loadTopSpace(width: CGFloat) -> some View {
        AnyView(
            Group {
                if viewModel.isLogin {
                    TopSpaceView(
                        width: width,
                        height: Env.topSpaceHeight,
                        color: .orange,
                        text: L10n.Button.ShowFavoritePhotos.title) {
                        showFavorite = true
                    }
                    .sheet(isPresented: $showFavorite) {
                        FavoritePhotoView()
                    }
                } else {
                    TopSpaceView(
                        width: width,
                        height: Env.topSpaceHeight,
                        color: .pink,
                        text: L10n.Button.SignIn.title) {
                        viewModel.signInRequest()
                    }
                }
            }
        )
    }
}

#if DEBUG
struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(DeviceType.allCases, id: \.self) { device in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: device.rawValue))
                .previewDisplayName(device.rawValue)
                .environment(\.locale, .init(identifier: LanguageType.english.rawValue))
                .environment(\.colorScheme, .light)
        }
    }
}
#endif
