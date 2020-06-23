//
//  Store+AK.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import VueFlux

public extension Store {
    convenience init(state: State, mutations: State.Mutations, isMainThread: Bool = false) {
        self.init(state: state, mutations: mutations, executor: .queue(isMainThread ? .main : .global()))
    }
}
