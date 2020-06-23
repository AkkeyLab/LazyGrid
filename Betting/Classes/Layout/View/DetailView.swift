//
//  DetailView.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    private enum Const {
        static let buttonHeight: CGFloat = 50
        static let sideMargin: CGFloat = 8
        static let bottomPadding: CGFloat = 16
        static let buttonSpacing: CGFloat = 8
    }

    @ObservedObject private var viewModel = DetailViewModel()
    internal let imageURL: URL?
    internal let title: String
    internal let photoId: String

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: .zero) {
                Text(title)
                    .font(.system(.title, design: Font.Design.monospaced))
                CustomImage(url: imageURL) {
                    $0
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                }
                Spacer()
                VStack(spacing: Const.buttonSpacing) {
                    loadBottomSpace(width: geometry.size.width - Const.sideMargin * 2)
                        .cornerRadius(Const.buttonHeight / 2)
                    Text(L10n.Button.Favorite.subscript)
                        .font(.caption)
                }
                .padding(.bottom, Const.bottomPadding)
            }
        }
        .alert(isPresented: $viewModel.alert.state) {
            viewModel.alert.alert
        }
    }

    private func loadBottomSpace(width: CGFloat) -> some View {
        AnyView(
            Group {
                if viewModel.isLogin {
                    Button(
                        action: {
                            viewModel.favorite(photoId: photoId)
                        },
                        label: {
                            Text(L10n.Button.Favorite.title)
                                .font(.body)
                                .foregroundColor(Color.white)
                                .contentShape(Rectangle())
                                .frame(width: width, height: Const.buttonHeight)
                                .background(Color.orange)
                        }
                    )
                } else {
                    Button(
                        action: {
                            viewModel.signIn()
                        },
                        label: {
                            Text(L10n.Button.SignIn.title)
                                .font(.body)
                                .foregroundColor(Color.white)
                                .contentShape(Rectangle())
                                .frame(width: width, height: Const.buttonHeight)
                                .background(Color.pink)
                        }
                    )
                }
            }
        )
    }
}

#if DEBUG
struct DetailViewPreviews: PreviewProvider {
    private static let urlString = "https://avatars0.githubusercontent.com/u/10639145?s=200&v=4"
    private static let sampleImageURL = URL(string: urlString)!
    static var previews: some View {
        DetailView(imageURL: sampleImageURL, title: "Apple", photoId: "")
    }
}
#endif
