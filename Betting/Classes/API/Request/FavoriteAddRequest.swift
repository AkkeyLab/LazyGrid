//
//  FavoriteAddRequest.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import OAuthSwift
import Moya

struct FavoriteAddRequest: FlickrAuthType {
    typealias Response = FavoriteAddResponse

    var method: Moya.Method {
        .post
    }

    var path: String {
        "/services/rest"
    }

    var task: Task {
        var param: [String: Any] = [
            "api_key": consumerKey,
            "auth_token": authToken,
            "photo_id": photoId,
            "method": "flickr.favorites.add",
            "format": "json",
            "nojsoncallback": 1
        ]
        var url = baseURL
        url.appendPathComponent(path)
        param["api_sig"] = OAuthSwiftCredential(consumerKey: consumerKey, consumerSecret: consumerSecret)
            .signature(method: .GET, url: url, parameters: param)
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }

    var sampleData: Data {
        let path = Bundle.main.path(forResource: "FavoriteAddResponse", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }

    private let photoId: String
    private let authToken: String
    private let consumerKey: String
    private let consumerSecret: String
    init(photoId: String,
         authToken: String = KeychainAccessHelper.authToken.data ?? "",
         consumerKey: String = KeyHelper.consumerKey,
         consumerSecret: String = KeyHelper.consumerSecret) {
        self.photoId = photoId
        self.authToken = authToken
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
    }
}
