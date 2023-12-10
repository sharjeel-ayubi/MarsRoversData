//
//  OpportunityPhotosRequest.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

/**
 - Request to fetch photos of Opportunity
 - Response type is set in the request
 - All the entities are made get-only except for page number which will be set from outside
 */

struct OpportunityPhotosRequest: DataRequest {

    typealias Response = PhotosResponse
    
    private var page: Int
    private var path: String {
        "/opportunity/photos"
    }
    private var scheme: String {
        PhotosAPI.scheme
    }
    private var host: String {
        PhotosAPI.url
    }
    
    var url: String {
        scheme + "://" + host + path
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [String : String] {
        return [ParameterKeys.sol : "1000",
                ParameterKeys.apiKey : PhotosAPI.apiKey,
                ParameterKeys.page : String(page)]
    }
    
    init(page: Int) {
        self.page = page
    }
}
