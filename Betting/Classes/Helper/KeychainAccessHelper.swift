//
//  KeychainAccessHelper.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import KeychainAccess

enum KeychainAccessHelper: String {
    case authToken

    private var keychain: Keychain {
        Keychain(service: Bundle.main.bundleIdentifier ?? "")
    }

    func save(_ data: String) {
        keychain[self.rawValue] = data
    }

    var data: String? {
        try? keychain.get(self.rawValue)
    }
}
