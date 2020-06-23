//
//  SearchState.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import RxSwift
import VueFlux

extension Computed where State == SearchState {
    var interestingness: Observable<PhotoList> {
        state.interestingness.asObservable().share()
    }

    var photoLoadFailure: Observable<PhotoLoadError> {
        state.photoLoadFailure.asObservable().share()
    }
}

final class SearchState: State {
    typealias Action = SearchAction
    typealias Mutations = SearchMutations

    fileprivate let interestingness = PublishSubject<PhotoList>()
    fileprivate let photoLoadFailure = PublishSubject<PhotoLoadError>()
}

struct SearchMutations: Mutations {
    typealias State = SearchState

    func commit(action: SearchAction, state: SearchState) {
        switch action {
        case .update(let result):
            state.interestingness.onNext(result)
        case .photoLoadFailure(let error):
            state.photoLoadFailure.onNext(error)
        }
    }
}
