//
//  NetworkManager.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 12/11/2023.
//

import Foundation

protocol NetworkService {
    func sendRequest<T: Decodable>(endpoint: Router, responseModel: T.Type) async throws -> T
}

extension NetworkService {
    func sendRequest<T: Decodable>(
        endpoint: Router,
        responseModel: T.Type
    ) async throws -> T {

        var request = URLComponents(string: endpoint.url)!

        if let parameters = endpoint.parameters {
            request.queryItems = parameters
        }

        guard let url = request.url else { throw NetworkError.invalidURL }
        print("URL: \(url.absoluteString)")
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = endpoint.method.rawValue

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response:")
                    print(responseString)
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw NetworkError.decode
                }
                return decodedResponse
            case 401:
                throw NetworkError.unauthorised
            default:
                throw NetworkError.unknown
            }
        } catch URLError.Code.notConnectedToInternet {
            throw NetworkError.offline
        }
    }
}
