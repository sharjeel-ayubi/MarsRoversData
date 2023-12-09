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

enum NetworkError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorised
    case offline
    case unknown

    var customMessage: String {
        switch self {
        case .offline:
            return "You are not connected to Internet"
        default:
            return "Something Went Wrong"
        }
    }
}
