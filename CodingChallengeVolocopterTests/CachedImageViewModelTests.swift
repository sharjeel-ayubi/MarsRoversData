//
//  CachedImageViewModelTests.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 26/12/2023.
//

import XCTest

final class CachedImageViewModelTests: XCTestCase {

    var viewModel: CachedImageViewModel!
    let testURL = URL(string: "http://mars.nasa.gov/mer/gallery/all/2/n/1000/2N215136972EDNAS00P1585L0M1-BR.JPG")!
    let testURL2 = URL(string: "https://www.api.example.com/1")!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testLoadImageFromCache() {
        viewModel = CachedImageViewModel(url: testURL)
            // Mocking a cached response
            let cachedData = "MockCachedData".data(using: .utf8)!
            let cachedResponse = CachedURLResponse(response: HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: cachedData)
            URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: testURL))

            let expectation = XCTestExpectation(description: "Load image from cache")
            
        viewModel.loadImage { data in
                XCTAssertEqual(data, cachedData)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 5.0)
        }

        func testErrorHandling() {
            let expectation = XCTestExpectation(description: "Handle error")

            // Create a URLSessionMock for testing network errors
            let urlSessionMock = MockURLSession(data: nil, response: nil, error: NSError(domain: "TestErrorDomain", code: 500, userInfo: nil))
            
            viewModel = CachedImageViewModel(url: testURL2, urlSession: urlSessionMock)

            viewModel.loadImage { data in
                XCTAssertNil(data)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 5.0)
        }

}
