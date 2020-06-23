//
//  PhotoListResponse.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

struct PhotoListResponse: Codable {
    let photos: Photos
    let stat: String
    let message: String?
    let code: Int?

    struct Photos: Codable {
        let page: Int
        let pages: Int
        let perpage: Int
        let photo: [Photo]
    }

    // swiftlint:disable identifier_name nesting
    struct Photo: Codable {
        let id: String
        let owner: String
        let title: String
        let isPublic: Int
        let isFriend: Int
        let isFamily: Int
        let dateTaken: String
        let url: String?
        let height: Float?
        let width: Float?

        enum CodingKeys: String, CodingKey {
            case isPublic = "ispublic"
            case isFriend = "isfriend"
            case isFamily = "isfamily"
            case dateTaken = "datetaken"
            case url = "url_h"
            case height = "height_h"
            case width = "width_h"
            case id, owner, title
        }
    }
    // swiftlint:enable identifier_name nesting
}
