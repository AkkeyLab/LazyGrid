//
//  AuthActions.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import OAuthSwift
import Moya
import RxSwift
import VueFlux

enum AuthAction {
    case updateUserId(String)
    case updateOAuthToken(String)
    case updateUserFullName(String)
    case updateUserName(String)
    case authFailure(AuthError)
}

extension Actions where State == AuthState {
    func loginTest(provider: MoyaProvider<MultiTarget> = .init()) -> Disposable {
        FlickrAPI(provider: provider)
            .request(request: LoginTestRequest())
            .subscribe(
                onSuccess: { res in
                    let result = res.convert()
                    guard let errorCode = result.code else {
                        self.dispatch(action: .updateUserId(res.convert().user?.id ?? ""))
                        return
                    }
                    switch errorCode {
                    case 95...100, 111...116:
                        self.dispatch(action: .authFailure(.developerError))
                    case 105:
                        self.dispatch(action: .authFailure(.maintenance))
                    case 106:
                        self.dispatch(action: .authFailure(.requiredRetry))
                    default:
                        self.dispatch(action: .authFailure(.networkError))
                    }
                },
                onError: { _ in
                    self.dispatch(action: .authFailure(.networkError))
                }
            )
    }

    func signIn(manager: AuthInfoManager = .shared) -> Disposable {
        guard let callbackURL = URL(string: "com.akkeylab.app.Betting://oauth-callback/flickr") else {
            dispatch(action: .authFailure(.signInFailed))
            return Disposables.create()
        }
        return manager.authInfo.rx.authorize(withCallbackURL: callbackURL)
            .subscribe(
                onNext: { credential, parameters in
                    self.dispatch(action: .updateOAuthToken(credential.oauthToken))
                    if let name = (parameters["username"] as? String)?.removingPercentEncoding {
                        self.dispatch(action: .updateUserName(name))
                    }
                    if let name = (parameters["fullname"] as? String)?.removingPercentEncoding {
                        self.dispatch(action: .updateUserFullName(name))
                    }
                    if let userId = (parameters["user_nsid"] as? String)?.removingPercentEncoding {
                        self.dispatch(action: .updateUserId(userId))
                    }
                },
                onError: { _ in
                    self.dispatch(action: .authFailure(.signInFailed))
                }
            )
      }
}
