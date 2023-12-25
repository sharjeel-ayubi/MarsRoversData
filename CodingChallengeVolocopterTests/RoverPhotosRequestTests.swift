//
//  RoverPhotosRequestTests.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 25/12/2023.
//

import XCTest

final class RoverPhotosRequestTests: XCTestCase {

    var networkService: NetworkService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = DefaultNetworkService()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }
    
    func testCuriosityDataRequest() {
        let expectation = XCTestExpectation(description: "Curiosity Network request completed successfully")
        
        let dataRequest = CuriosityPhotosRequest(page: 1, filter: "NAVCAM")
        
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
    
    func testSpiritDataRequest() {
        let expectation = XCTestExpectation(description: "Spirit Network request completed successfully")
        
        let dataRequest = SpiritPhotosRequest(page: 1, filter: "NAVCAM")
        
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
    
    func testOpportunityDataRequest() {
        let expectation = XCTestExpectation(description: "Opportunity Network request completed successfully")
        
        let dataRequest = OpportunityPhotosRequest(page: 1, filter: "NAVCAM")
        
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

}
