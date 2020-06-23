//
//  NSObject+Apply.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

protocol Appliable {}

extension Appliable {
    @discardableResult
    internal func apply(closure: (_ this: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Appliable {}
