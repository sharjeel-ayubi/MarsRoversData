//
//  MockApiRequest.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 25/12/2023.
//

import Foundation

struct MockApiRequest: DataRequest {

    typealias Response = PhotosResponse
    private let urlString:String
    var url: String {
        urlString
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    init(urlString:String) {
        self.urlString = urlString
    }
}
