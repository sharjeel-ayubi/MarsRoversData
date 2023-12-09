//
//  NetworkConstants.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

protocol API {
    static var scheme: String { get }
    static var url: String { get }
    static var apiKey: String { get }
}

struct PhotosAPI: API {
    static var scheme = "https"
    static var url = "api.nasa.gov/mars-photos/api/v1/rovers"
    static var apiKey = "X3KZLq14eaMI5PlIerYO7y6XT6pvCPAgsWw9bysq"
}

struct ParameterKeys {
    static let sol = "sol"
    static let apiKey = "api_key"
    static let page = "page"
}
