//
//  FavoriteActions.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Moya
import RxSwift
import VueFlux

enum FavoriteAction {
    case update(PhotoList)
    case success
    case photoFavoriteFailure(FavoriteError)
    case photoLoadFailure(PhotoLoadError)
}

extension Actions where State == FavoriteState {
    func favorite(photoId: String, provider: MoyaProvider<MultiTarget> = .init()) -> Disposable {
        FlickrAPI(provider: provider)
            .request(request: FavoriteAddRequest(photoId: photoId))
            .subscribe(
                onSuccess: { res in
                    let result = res.convert()
                    guard let errorCode = result.code else {
                        self.dispatch(action: .success)
                        return
                    }
                    switch errorCode {
                    case 1:
                        self.dispatch(action: .photoFavoriteFailure(.canNotAdd))
                    case 2:
                        self.dispatch(action: .photoFavoriteFailure(.owned))
                    case 3:
                        self.dispatch(action: .photoFavoriteFailure(.alreadyAdd))
                    case 4, 95...100, 111...116:
                        self.dispatch(action: .photoFavoriteFailure(.developerError))
                    case 105:
                        self.dispatch(action: .photoFavoriteFailure(.maintenance))
                    case 106:
                        self.dispatch(action: .photoFavoriteFailure(.requiredRetry))
                    default:
                        self.dispatch(action: .photoFavoriteFailure(.networkError))
                    }
                },
                onError: { _ in
                    self.dispatch(action: .photoFavoriteFailure(.networkError))
                }
            )
    }

    func loadFavorite(page: Int,
                      perPage: Int,
                      userId: String,
                      provider: MoyaProvider<MultiTarget> = .init()) -> Disposable {
        FlickrAPI(provider: provider)
            .request(request: FavoriteLoadRequest(page: page, perPage: perPage, userId: userId))
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
