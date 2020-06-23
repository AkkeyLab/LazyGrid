//
//  Array+.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
