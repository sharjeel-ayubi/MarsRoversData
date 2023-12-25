//
//  MockDataRequest.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 25/12/2023.
//

import Foundation

struct MockDataRequest: DataRequest {
        typealias Response = PhotosResponse

        var url: String
        var method: HTTPMethod
        var header: [String: String]
        var queryItems: [String: String]
        var requestTimeOut: Float?

        init(url: String, method: HTTPMethod, header: [String: String], queryItems: [String: String], requestTimeOut: Float?) {
            self.url = url
            self.method = method
            self.header = header
            self.queryItems = queryItems
            self.requestTimeOut = requestTimeOut
        }
    }
