//
//  Router.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

enum Router: Equatable {
    case curiosity(page: Int)
    case opportunity(page: Int)
    case spirit(page: Int)
    
    var scheme: String {
        PhotosAPI.scheme
    }
    var host: String {
        PhotosAPI.url
    }
    var url: String {
        scheme + "://" + host + path
    }
    
    
    
    var path: String {
        switch self {
        case .curiosity:
            return "/curiosity/photos"
        case .opportunity:
            return "/opportunity/photos"
        case .spirit:
            return "/spirit/photos"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .curiosity(let page),
             .opportunity(let page),
             .spirit(let page):
            return [URLQueryItem(name: ParameterKeys.sol, value: "1000"),
                    URLQueryItem(name: ParameterKeys.apiKey, value: PhotosAPI.apiKey),
                    URLQueryItem(name: ParameterKeys.page, value: String(page))]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .curiosity, .opportunity, .spirit:
            return .get
        }
    }
}
