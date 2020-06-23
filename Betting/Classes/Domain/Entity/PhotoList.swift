//
//  Interestingness.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Foundation

struct PhotoList {
    let photos: Photos
    let stat: String
    let message: String?
    let code: Int?

    struct Photos {
        let page: Int
        let pages: Int
        let perpage: Int
        let photo: [Photo]
    }

    // swiftlint:disable identifier_name
    struct Photo {
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
    }
    // swiftlint:enable identifier_name
}

extension PhotoListResponse: Convertible {
    typealias Entity = PhotoList

    func convert() -> PhotoList {
        .init(photos: photos.convert(), stat: stat, message: message, code: code)
    }
}

extension PhotoListResponse.Photos: Convertible {
    typealias Entity = PhotoList.Photos

    func convert() -> PhotoList.Photos {
        .init(
            page: page,
            pages: pages,
            perpage: perpage,
            photo: photo.convert()
        )
    }
}

extension PhotoListResponse.Photo: Convertible {
    typealias Entity = PhotoList.Photo

    func convert() -> PhotoList.Photo {
        .init(
            id: id,
            owner: owner,
            title: title,
            isPublic: isPublic,
            isFriend: isFriend,
            isFamily: isFamily,
            dateTaken: dateTaken,
            url: url,
            height: height,
            width: width
        )
    }
}
