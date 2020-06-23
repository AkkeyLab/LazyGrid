//
//  SearchAction.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Moya
import RxSwift
import VueFlux

enum SearchAction {
    case update(PhotoList)
    case photoLoadFailure(PhotoLoadError)
}

extension Actions where State == SearchState {
    func interestingnessSearch(page: Int, perPage: Int, provider: MoyaProvider<MultiTarget> = .init()) -> Disposable {
        FlickrAPI(provider: provider)
            .request(request: InterestingnessRequest(page: page, perPage: perPage))
            .subscribe(
                onSuccess: { res in
                    let result = res.convert()
                    guard let errorCode = result.code else {
                        self.dispatch(action: .update(res.convert()))
                        return
                    }
                    switch errorCode {
                    case 1, 100, 111...116:
                        self.dispatch(action: .photoLoadFailure(.developerError))
                    case 105:
                        self.dispatch(action: .photoLoadFailure(.maintenance))
                    case 106:
                        self.dispatch(action: .photoLoadFailure(.requiredRetry))
                    default:
                        self.dispatch(action: .photoLoadFailure(.networkError))
                    }
                },
                onError: { _ in
                    self.dispatch(action: .photoLoadFailure(.networkError))
                }
            )
    }
}
