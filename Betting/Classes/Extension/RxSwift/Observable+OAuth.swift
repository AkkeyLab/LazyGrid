//
//  Observable+OAuth.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import OAuthSwift
import RxSwift

extension Reactive where Base: OAuth1Swift {
    func authorize(withCallbackURL url: URLConvertible) -> Observable<(OAuthSwiftCredential, OAuthSwift.Parameters)> {
        Observable<(OAuthSwiftCredential, OAuthSwift.Parameters)>.create { observer in
            self.base.authorize(withCallbackURL: url) { result in
                switch result {
                case .success(let obj):
                    observer.on(.next((obj.credential, obj.parameters)))
                case .failure(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
