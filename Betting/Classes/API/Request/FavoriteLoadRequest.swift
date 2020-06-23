//
//  FavoriteLoadRequest.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Moya

struct FavoriteLoadRequest: FlickrAuthLessType {
    typealias Response = PhotoListResponse

    var method: Method {
        .get
    }

    var path: String {
        "/services/rest"
    }

    var task: Task {
        let param: [String: Any] = [
            "api_key": apiKey,
            "method": "flickr.favorites.getList",
            "format": "json",
            "nojsoncallback": 1,
            "extras": "id,owner,title,ispublic,isfriend,isfamily,url_h,date_taken,url_h,height_h,width_h",
            "per_page": perPage,
            "page": page,
            "user_id": userId
        ]
        return .requestParameters(parameters: param, encoding: URLEncoding.default)
    }

    var sampleData: Data {
        let path = Bundle.main.path(forResource: "PhotoListResponse", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }

    private let apiKey: String
    private let page: Int
    private let perPage: Int
    private let userId: String
    init(apiKey: String = KeyHelper.consumerKey, page: Int, perPage: Int = 100, userId: String) {
        self.apiKey = apiKey
        self.page = page
        self.perPage = perPage
        self.userId = userId
    }
}
