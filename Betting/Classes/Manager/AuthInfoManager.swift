//
//  AuthInfoManager.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import OAuthSwift

final class AuthInfoManager {
    private enum Const {
        static let requestTokenUrl = "https://www.flickr.com/services/oauth/request_token"
        static let authorizeUrl = "https://www.flickr.com/services/oauth/authorize"
        static let accessTokenUrl = "https://www.flickr.com/services/oauth/access_token"
    }

    static let shared = AuthInfoManager()

    var authInfo: OAuth1Swift = {
        OAuth1Swift(
            consumerKey: KeyHelper.consumerKey,
            consumerSecret: KeyHelper.consumerSecret,
            requestTokenUrl: Const.requestTokenUrl,
            authorizeUrl: Const.authorizeUrl,
            accessTokenUrl: Const.accessTokenUrl
        )
    }()
}
