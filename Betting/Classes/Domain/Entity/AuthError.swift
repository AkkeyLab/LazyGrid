//
//  AuthError.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

enum AuthError {
    case developerError
    case maintenance
    case requiredRetry
    case networkError
    case signInFailed
}
