//
//  AuthState.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import RxCocoa
import RxSwift
import VueFlux

extension Computed where State == AuthState {
    var userId: Observable<String> {
        state.userId.asObservable().share()
    }

    var isLogin: Observable<Bool> {
        state.authState.asObservable().share()
    }

    var oauthToken: Observable<String> {
        state.oauthToken.asObservable().share()
    }

    var userFullName: Observable<String> {
        state.userFullName.asObservable().share()
    }

    var userName: Observable<String> {
        state.userName.asObservable().share()
    }

    var authError: Observable<AuthError> {
        state.authError.asObservable().share()
    }

    var isLoginValue: Bool {
        state.authState.value
    }
}

final class AuthState: State {
    typealias Action = AuthAction
    typealias Mutations = AuthMutations

    static let shared = AuthState()

    fileprivate let userId = PublishSubject<String>()
    fileprivate let authState = BehaviorRelay<Bool>(value: false)
    fileprivate let oauthToken = PublishSubject<String>()
    fileprivate let userFullName = PublishSubject<String>()
    fileprivate let userName = PublishSubject<String>()
    fileprivate let authError = PublishSubject<AuthError>()

}

struct AuthMutations: Mutations {
    typealias State = AuthState

    func commit(action: AuthAction, state: AuthState) {
        switch action {
        case .updateUserId(let userId):
            state.userId.onNext(userId)
            state.authState.accept(true)
        case .updateOAuthToken(let token):
            state.oauthToken.onNext(token)
            state.authState.accept(true)
        case .updateUserFullName(let name):
            state.userFullName.onNext(name)
        case .updateUserName(let name):
            state.userName.onNext(name)
        case .authFailure(let error):
            state.authError.onNext(error)
            state.authState.accept(false)
        }
    }
}
