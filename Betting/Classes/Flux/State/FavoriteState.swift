//
//  FavoriteState.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import RxSwift
import VueFlux

extension Computed where State == FavoriteState {
    var photoFavoriteFailure: Observable<FavoriteError> {
        state.photoFavoriteFailure.asObservable().share()
    }

    var success: Observable<Void> {
        state.success.asObservable().share()
    }

    var favoritePhoto: Observable<PhotoList> {
        state.favoritePhoto.asObservable().share()
    }

    var photoLoadFailure: Observable<PhotoLoadError> {
        state.photoLoadFailure.asObservable().share()
    }
}

final class FavoriteState: State {
    typealias Action = FavoriteAction
    typealias Mutations = FavoriteMutations

    fileprivate let success = PublishSubject<Void>()
    fileprivate let photoFavoriteFailure = PublishSubject<FavoriteError>()
    fileprivate let favoritePhoto = PublishSubject<PhotoList>()
    fileprivate let photoLoadFailure = PublishSubject<PhotoLoadError>()
}

struct FavoriteMutations: Mutations {
    typealias State = FavoriteState

    func commit(action: FavoriteState.Action, state: FavoriteState) {
        switch action {
        case .photoFavoriteFailure(let error):
            state.photoFavoriteFailure.onNext(error)
        case .success:
            state.success.onNext(())
        case .update(let list):
            state.favoritePhoto.onNext(list)
        case .photoLoadFailure(let error):
            state.photoLoadFailure.onNext(error)
        }
    }
}
