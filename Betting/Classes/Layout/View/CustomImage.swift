//
//  CustomImage.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import SwiftUI

struct CustomImage<T>: View where T: View {
    @ObservedObject internal var imageLoader = ImageLoader()
    private let url: URL?
    private let content: (_ image: Image) -> T

    init(url: URL?, content: @escaping (_ image: Image) -> T) {
        self.url = url
        self.content = content
    }

    var body: some View {
        content(imageLoader.image)
            .onAppear {
                imageLoader.load(url: url)
            }
    }
}

#if DEBUG
struct CustomImagePreviews: PreviewProvider {
    private static let urlString = "https://avatars0.githubusercontent.com/u/10639145?s=200&v=4"
    private static let sampleImageURL = URL(string: urlString)!
    static var previews: some View {
        CustomImage(url: sampleImageURL) {
            $0
                .resizable()
                .scaledToFill()
                .previewLayout(.fixed(width: 100, height: 100))
        }
    }
}
#endif
