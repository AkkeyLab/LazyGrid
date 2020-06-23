//
//  FavoritePhotoView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct FavoritePhotoView: View {
    private enum Const {
        static let topSpaceHeight: CGFloat = 80
    }

    @ObservedObject private var viewModel = FavoritePhotoViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    VStack {
                        Text(L10n.Button.ShowFavoritePhotos.title)
                            .font(.system(.title, design: Font.Design.monospaced))
                    }
                    .frame(width: geometry.size.width, height: Const.topSpaceHeight)
                    Spacer()
                }
                PhotoCollectionView(data: $viewModel.favorite, geometry: geometry)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $viewModel.alert.state) {
            viewModel.alert.alert
        }
    }
}

#if DEBUG
struct FavoritePhotoViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(DeviceType.allCases, id: \.self) { device in
            FavoritePhotoView()
                .previewDevice(PreviewDevice(rawValue: device.rawValue))
                .previewDisplayName(device.rawValue)
                .environment(\.locale, .init(identifier: LanguageType.english.rawValue))
                .environment(\.colorScheme, .light)
        }
    }
}
#endif
