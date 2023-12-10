//
//  NetworkService.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 12/11/2023.
//

import Foundation
import Combine

protocol NetworkService {
    var requestTimeOut: Float { get }
    func request<T: Codable>(_ req: any DataRequest) -> AnyPublisher<T, NetworkError>
}


final class DefaultNetworkService: NetworkService {
    public var requestTimeOut: Float = 30
    
    public func request<T>(_ request: any DataRequest) -> AnyPublisher<T, NetworkError> where T: Decodable, T: Encodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeOut)
        
        guard let urlRequest = request.buildRequest() else {
            return AnyPublisher(Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url")))
        }
        print("URL: \(urlRequest.url?.absoluteString ?? "")")
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { output in
                // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                print("Response:")
                print(String(data: output.data, encoding: .utf8) ?? "")
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
