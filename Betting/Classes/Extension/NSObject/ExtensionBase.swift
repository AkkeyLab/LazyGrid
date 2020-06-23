//
//  ExtensionBase.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
struct Akkey<Base> {
    internal let base: Base
    internal init(_ base: Base) {
        self.base = base
    }
}

protocol AkkeyCompatible {
    associatedtype CompatibleType
    static var ak: Akkey<CompatibleType>.Type { get }
    var ak: Akkey<CompatibleType> { get }
}

extension AkkeyCompatible {
    internal static var ak: Akkey<Self>.Type {
        return Akkey<Self>.self
    }
    internal var ak: Akkey<Self> {
        return Akkey(self)
    }
}
// swiftlint:enable identifier_name

extension NSObject: AkkeyCompatible {}
