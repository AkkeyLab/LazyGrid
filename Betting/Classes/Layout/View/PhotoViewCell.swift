//
//  PhotoViewCell.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct PhotoViewCell: View {
    private enum Const {
        static let cornerRadius: CGFloat = 8
        static let shadowRadius: CGFloat = 8
    }

    internal let url: URL?
    internal let title: String

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                CustomImage(url: url) {
                    $0
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: Const.cornerRadius))
                        .shadow(color: Assets.primaryShadow.color.toColor, radius: Const.shadowRadius)
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        PriceView(color: .white, title: title)
                            .frame(width: geometry.size.width / 2, height: geometry.size.height / 5)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct PhotoViewCellPreviews: PreviewProvider {
    private static let urlString = "https://avatars0.githubusercontent.com/u/10639145?s=200&v=4"
    private static let sampleImageURL = URL(string: urlString)
    static var previews: some View {
        PhotoViewCell(url: sampleImageURL, title: "Apple")
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
#endif
