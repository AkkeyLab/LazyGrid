//
//  SearchViewModel.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import DefaultsKit
import RxSwift
import SwiftUI
import VueFlux

final class SearchViewModel: ObservableObject {
    @Published var interestingness: [PhotoList.Photo] = []
    @Published var alert = AlertState()
    @Published var isLogin = false
    private let searchStore: Store<SearchState>
    private let authStore: Store<AuthState>
    private let defaultKit: Defaults
    private let bag = DisposeBag()

    init(searchStore: Store<SearchState> = .init(state: .init(), mutations: .init(), isMainThread: true),
         authStore: Store<AuthState> = .init(state: .shared, mutations: .init(), isMainThread: true),
         defaultKit: Defaults = .shared) {
        self.searchStore = searchStore
        self.authStore = authStore
        self.defaultKit = defaultKit

        addObserver()
        interestingnessSearch()
        loginTest()
    }

    // swiftlint:disable function_body_length
    private func addObserver() {
        searchStore.computed.interestingness
            .map { $0.photos.photo }
            .subscribe(onNext: { [weak self] result in
                self?.interestingness = result.filter { $0.url != nil }
            })
            .disposed(by: bag)
        authStore.computed.userId
            .subscribe(onNext: { [weak self] userId in
                self?.defaultKit.set(userId, for: .userId)
            })
            .disposed(by: bag)
        authStore.computed.isLogin
            .subscribe(onNext: { [weak self] isLogin in
                self?.isLogin = isLogin
            })
            .disposed(by: bag)
        authStore.computed.oauthToken
            .subscribe(onNext: { token in
                KeychainAccessHelper.authToken.save(token)
            })
            .disposed(by: bag)
        authStore.computed.userFullName
            .subscribe(onNext: { [weak self] name in
                self?.defaultKit.set(name, for: .userFullName)
            })
            .disposed(by: bag)
        authStore.computed.userName
            .subscribe(onNext: { [weak self] name in
                self?.defaultKit.set(name, for: .userName)
            })
            .disposed(by: bag)
        searchStore.computed.photoLoadFailure
            .subscribe(onNext: { [weak self] type in
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
        authStore.computed.authError
            .subscribe(onNext: { [weak self] type in
                switch type {
                case .developerError:
                    self?.alert = AlertState(state: true, type: .developerError)
                case .maintenance:
                    self?.alert = AlertState(state: true, type: .maintenance)
                case .requiredRetry:
                    self?.alert = AlertState(state: true, type: .requiredRetry)
                case .networkError:
                    self?.alert = AlertState(state: true, type: .networkError)
                case .signInFailed:
                    self?.alert = AlertState(state: true, type: .signInFailed)
                }
            })
            .disposed(by: bag)
    }
    // swiftlint:enable function_body_length
}

extension SearchViewModel {
    internal func signInRequest() {
        alert = AlertState(state: true, type: .confirmBeforeSignIn) { [weak self] in
            self?.signIn()
        }
    }

    private func interestingnessSearch() {
        // Support additional loading by additional development.
        searchStore
            .actions
            .interestingnessSearch(page: 1, perPage: 50)
            .disposed(by: bag)
    }

    private func loginTest() {
        guard !(KeychainAccessHelper.authToken.data?.isEmpty ?? true) else { return }
        authStore
            .actions
            .loginTest()
            .disposed(by: bag)
    }

    private func signIn() {
        Store<AuthState>
            .actions
            .signIn()
            .disposed(by: bag)
    }
}
