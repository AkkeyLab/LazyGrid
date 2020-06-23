//
//  DetailViewModel.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import RxSwift
import SwiftUI
import VueFlux

final class DetailViewModel: ObservableObject {
    @Published var isLogin = false
    @Published var alert = AlertState()
    private let authStore: Store<AuthState>
    private let favoriteStore: Store<FavoriteState>
    private let bag = DisposeBag()

    init(authStore: Store<AuthState> = .init(state: .shared, mutations: .init(), isMainThread: true),
         favoriteStore: Store<FavoriteState> = .init(state: .init(), mutations: .init(), isMainThread: true)) {
        self.authStore = authStore
        self.favoriteStore = favoriteStore

        isLogin = authStore.computed.isLoginValue
        addObserver()
    }
}

extension DetailViewModel {
    internal func signIn() {
        Store<AuthState>
            .actions
            .signIn()
            .disposed(by: bag)
    }

    internal func favorite(photoId: String) {
        favoriteStore
            .actions
            .favorite(photoId: photoId)
            .disposed(by: bag)
    }

    private func addObserver() {
        authStore.computed.isLogin
            .subscribe(onNext: { [weak self] isLogin in
                self?.isLogin = isLogin
            })
            .disposed(by: bag)
        favoriteStore.computed.success
            .subscribe(onNext: { [weak self] in
                self?.alert = AlertState(state: true, type: .successFavorite)
            })
            .disposed(by: bag)
        favoriteStore.computed.photoFavoriteFailure
            .subscribe(onNext: { [weak self] type in
                switch type {
                case .canNotAdd:
                    self?.alert = AlertState(state: true, type: .canNotAddFavorite)
                case .owned:
                    self?.alert = AlertState(state: true, type: .ownedPhoto)
                case .alreadyAdd:
                    self?.alert = AlertState(state: true, type: .alreadyAddFavorite)
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
    }
}
