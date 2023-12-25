//
//  NetworkServiceTests.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 25/12/2023.
//

import XCTest

final class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = DefaultNetworkService()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }
    
    // Test a successful network request
    func testSuccessfulNetworkRequest() {
        let expectation = XCTestExpectation(description: "Network request completed successfully")
        
        let dataRequest = CuriosityPhotosRequest(page: 1)
        
        let cancellable = networkService.request(dataRequest)
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Unexpected error: \(error)")
                }
            } receiveValue: { (response: PhotosResponse) in
                XCTAssertNotNil(response)
                XCTAssertGreaterThan(response.photos.count, 0)
            }
        
        wait(for: [expectation], timeout: 10.0)
        cancellable.cancel()
    }
    
    // Test a network request with an invalid URL
    func testNetworkRequestWithInvalidURL() {
        let dataRequest = MockApiRequest(urlString: "http://www.google")
        
        let cancellable = networkService.request(dataRequest)
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but request succeeded")
                case .failure(let error):
                    XCTAssertNotNil(error, "Expected an error, but received nil")
                }
            } receiveValue: { (response: PhotosResponse) in
                XCTFail("Expected failure, but received a response")
            }
        
        cancellable.cancel()
    }
    
    // Test a network request with JSON decoding error
    func testNetworkRequestWithJSONDecodingError() {
        let expectation = XCTestExpectation(description: "Network request completed with JSON decoding error")
        
        let dataRequest = MockApiRequest(urlString: "https://jsonplaceholder.typicode.com/todos/1")
        
        let cancellable = networkService.request(dataRequest)
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but request succeeded")
                case .failure(let error):
                    XCTAssertNotNil(error, "Expected a JSON decoding error, but received nil")
                    expectation.fulfill()
                }
            } receiveValue: { (response: PhotosResponse) in
                XCTFail("Expected failure, but received a response")
            }
        
        wait(for: [expectation], timeout: 10.0)
        cancellable.cancel()
    }
    
}
