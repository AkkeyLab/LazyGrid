//
//  Convertible.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

protocol Convertible {
    associatedtype Entity
    func convert() -> Entity
}

extension Array: Convertible where Element: Convertible {
    typealias Entity = [Element.Entity]

    func convert() -> [Element.Entity] {
        return map { $0.convert() }
    }
}
