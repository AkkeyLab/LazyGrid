//
//  FavoriteAddResponse.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

struct FavoriteAddResponse: Codable {
    let stat: String
    let message: String?
    let code: Int?
}
