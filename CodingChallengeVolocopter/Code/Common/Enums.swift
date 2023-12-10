//
//  Enums.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

//MARK: - Tabs Enum
enum Tabs: Int, CaseIterable {
    case curiosity = 0
    case opportunity = 1
    case spirit = 2
    
    var name: String {
        switch self {
        case .curiosity:
            return "Curiosity"
        case .opportunity:
            return "Opportunity"
        case .spirit:
            return "Spirit"
        }
    }
}

//MARK: - Network Enums
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

//enum NetworkError: Error {
//    case decode
//    case invalidURL
//    case noResponse
//    case unauthorised
//    case offline
//    case unknown
//
//    var customMessage: String {
//        switch self {
//        case .offline:
//            return "You are not connected to Internet"
//        default:
//            return "Something Went Wrong"
//        }
//    }
//}
public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}
