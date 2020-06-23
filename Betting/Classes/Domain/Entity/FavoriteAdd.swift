//
//  FavoriteAdd.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

struct FavoriteAdd {
    let stat: String
    let message: String?
    let code: Int?
}

extension FavoriteAddResponse: Convertible {
    typealias Entity = FavoriteAdd

    func convert() -> FavoriteAdd {
        .init(stat: stat, message: message, code: code)
    }
}
