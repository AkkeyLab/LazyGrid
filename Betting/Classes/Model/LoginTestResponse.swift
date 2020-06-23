//
//  LoginTestResponse.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

struct LoginTestResponse: Codable {
    let user: User?
    let stat: String
    let message: String?
    let code: Int?

    // swiftlint:disable identifier_name nesting
    struct User: Codable {
        let id: String
        let userName: UserName
        let pathAlias: String?

        enum CodingKeys: String, CodingKey {
            case pathAlias = "path_alias"
            case userName = "username"
            case id
        }
    }

    struct UserName: Codable {
        let content: String

        enum CodingKeys: String, CodingKey {
            case content = "_content"
        }
    }
    // swiftlint:enable identifier_name nesting
}
