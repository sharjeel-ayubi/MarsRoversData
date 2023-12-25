//
//  MockURLSession.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 26/12/2023.
//

import Foundation

class MockURLSession: URLSession {
    var data: Data?
        var response: URLResponse?
        var error: Error?

        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }

        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return MockURLSessionDataTask {
                completionHandler(self.data, self.response, self.error)
            }
        }
}

// Mock URLSessionDataTask for testing
class MockURLSessionDataTask: URLSessionDataTask {
    private let completionHandler: () -> Void
    
    init(completionHandler: @escaping () -> Void) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        completionHandler()
    }
}
