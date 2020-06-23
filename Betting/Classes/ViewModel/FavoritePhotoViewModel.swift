//
//  FavoritePhotoViewModel.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import AKProcessIndicator
import DefaultsKit
import RxSwift
import SwiftUI
import VueFlux

final class FavoritePhotoViewModel: ObservableObject {
    @Published var favorite: [PhotoList.Photo] = []
    @Published var alert = AlertState()
    private let favoriteStore: Store<FavoriteState>
    private let defaultKit: Defaults
    private let app: UIApplication
    private let bag = DisposeBag()

    init(favoriteStore: Store<FavoriteState> = .init(state: .init(), mutations: .init(), isMainThread: true),
         defaultKit: Defaults = .shared,
         app: UIApplication = .shared) {
        self.favoriteStore = favoriteStore
        self.defaultKit = defaultKit
        self.app = app

        addObserver()
        load()
    }

    private func addObserver() {
        favoriteStore.computed.photoLoadFailure
            .subscribe(onNext: { [weak self] type in
                self?.app.isLoding = false
                switch type {
                case .developerError:
                    self?.alert = AlertState(state: true, type: .developerError)
                case .maintenance:
                    self?.alert = AlertState(state: true, type: .maintenance)
                case .requiredRetry:
                    self?.alert = AlertState(state: true, type: .requiredRetry)
                case .networkError:
                    self?.alert = AlertState(state: true, type: .networkError)
                }
            })
            .disposed(by: bag)
        favoriteStore.computed.favoritePhoto
            .map { $0.photos.photo }
            .subscribe(onNext: { [weak self] list in
                self?.app.isLoding = false
                self?.favorite = list
            })
            .disposed(by: bag)
    }

    private func load() {
        guard let userId = defaultKit.get(for: .userId) else {
            alert = AlertState(state: true, type: .networkError)
            return
        }
        // Support additional loading by additional development.
        app.isLoding = true
        favoriteStore
            .actions
            .loadFavorite(page: 1, perPage: 50, userId: userId)
            .disposed(by: bag)
    }
}
