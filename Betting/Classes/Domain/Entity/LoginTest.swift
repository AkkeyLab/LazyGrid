//
//  LoginTest.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

struct LoginTest {
    let user: User?
    let stat: String
    let message: String?
    let code: Int?

    // swiftlint:disable identifier_name
    struct User {
        let id: String
        let userName: UserName
        let pathAlias: String?
    }
    // swiftlint:enable identifier_name

    struct UserName {
        let content: String
    }
}

extension LoginTestResponse: Convertible {
    typealias Entity = LoginTest

    func convert() -> LoginTest {
        .init(user: user?.convert(), stat: stat, message: message, code: code)
    }
}

extension LoginTestResponse.User: Convertible {
    typealias Entity = LoginTest.User

    func convert() -> LoginTest.User {
        .init(id: id, userName: userName.convert(), pathAlias: pathAlias)
    }
}

extension LoginTestResponse.UserName: Convertible {
    typealias Entity = LoginTest.UserName

    func convert() -> LoginTest.UserName {
        .init(content: content)
    }
}
