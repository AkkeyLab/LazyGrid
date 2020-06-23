//
//  FlickrAPI.swift
//  Betting
//
//  Created by AKIO on 2020/06/23.
//  Copyright © 2020 AKIO. All rights reserved.
//

import Moya
import RxSwift

final class FlickrAPI: ObservableObject {
    private let provider: MoyaProvider<MultiTarget>

    init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }

    internal func request<T>(request: T) -> Single<T.Response> where T: FlickrAuthLessType {
        provider.rx.request(MultiTarget(request))
            .filterSuccessfulStatusCodes()
            .map(T.Response.self)
    }

    internal func request<T>(request: T) -> Single<T.Response> where T: FlickrAuthType {
        provider.rx.request(MultiTarget(request))
            .filterSuccessfulStatusCodes()
            .map(T.Response.self)
    }
}

protocol FlickrAuthLessType: TargetType {
    associatedtype Response: Codable
}

extension FlickrAuthLessType {
    var consumerKey: String {
        KeyHelper.consumerKey
    }

    var baseURL: URL {
        URL(string: "https://api.flickr.com")!
    }

    var headers: [String: String]? {
        nil
    }
}

protocol FlickrAuthType: TargetType {
    associatedtype Response: Codable
}

extension FlickrAuthType {
    var consumerKey: String {
        KeyHelper.consumerKey
    }

    var baseURL: URL {
        URL(string: "https://api.flickr.com")!
    }

    var headers: [String: String]? {
        ["Authorization": KeychainAccessHelper.authToken.data ?? ""]
    }
}
