//
//  DataRequest.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 10/12/2023.
//

import Foundation
import UIKit

protocol DataRequest {
    associatedtype Response
    
    var url: String { get }
    var method: HTTPMethod { get }
    var header: [String:String] { get }
    var queryItems: [String:String] { get }
    var requestTimeOut: Float? { get }
    
    func decode(_ data: Data) throws -> Response
    func buildRequest() -> URLRequest?
}

extension DataRequest where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
}

extension DataRequest {
    
    func buildRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: self.url) else {
            return nil
        }
        
        var queryItems: [URLQueryItem] = []
        self.queryItems.forEach {
            let queryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(queryItem)
        }
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url, UIApplication.shared.canOpenURL(url) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.header
        
        return urlRequest
    }
}

extension DataRequest {
    var header: [String:String] { [:] }
    var queryItems: [String:String] { [:] }
    var requestTimeOut : Float? { nil }
}
