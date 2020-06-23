//
//  ImageLoader.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Combine
import SwiftUI
import Nuke

final class ImageLoader: ObservableObject {
    @Published var image: SwiftUI.Image = Assets.default.image.toImage
    private var cancellable: AnyCancellable?

    deinit {
        cancellable?.cancel()
    }

    internal func load(url: URL?) {
        guard let url = url else { return }
        cancellable = ImagePipeline.shared.imagePublisher(with: url)
            .sink(
                receiveCompletion: { [weak self] res in
                    switch res {
                    case .failure:
                        self?.image = Assets.default.image.toImage
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] res in
                    self?.image = res.image.toImage
                }
            )
    }
}
