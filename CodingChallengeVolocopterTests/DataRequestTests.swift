//
//  DataRequestTests.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 25/12/2023.
//

import XCTest

final class DataRequestTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBuildValidRequest() {
        let request = MockDataRequest(url: "https://api.example.com", method: .get, header: ["Authorization": "Bearer Token"], queryItems: ["param": "value"], requestTimeOut: 30.0)
        
        guard let urlRequest = request.buildRequest() else {
            XCTFail("Failed to build a valid request")
            return
        }
        
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://api.example.com?param=value")
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["Authorization"], "Bearer Token")
    }
    
    func testBuildRequestWithInvalidURL() {
        let request = MockDataRequest(url: "invalid-url", method: .get, header: [:], queryItems: [:], requestTimeOut: nil)
        
        XCTAssertNil(request.buildRequest())
    }
    
    func testDecodeResponseData() {
        let responseData = """
                {
                  "photos": [
                    {
                      "id": 301536,
                      "sol": 1000,
                      "camera": {
                        "id": 29,
                        "name": "NAVCAM",
                        "rover_id": 7,
                        "full_name": "Navigation Camera"
                      },
                      "img_src": "http://mars.nasa.gov/mer/gallery/all/2/n/1000/2N215136972EDNAS00P1585L0M1-BR.JPG",
                      "earth_date": "2006-10-27",
                      "rover": {
                        "id": 7,
                        "name": "Spirit",
                        "landing_date": "2004-01-04",
                        "launch_date": "2003-06-10",
                        "status": "complete",
                        "max_sol": 2208,
                        "max_date": "2010-03-21",
                        "total_photos": 124550,
                        "cameras": [
                          {
                            "name": "FHAZ",
                            "full_name": "Front Hazard Avoidance Camera"
                          }
                        ]
                      }
                    }
                  ]
                }
                """.data(using: .utf8)!
        
        do {
            let request = MockDataRequest(url: "https://api.example.com", method: .get, header: [:], queryItems: [:], requestTimeOut: nil)
            let decodedResponse: PhotosResponse = try request.decode(responseData)
            
            // Add assertions based on the expected response structure
            XCTAssertEqual(decodedResponse.photos.first?.id, 301536)
        } catch {
            XCTFail("Unexpected error decoding response data: \(error)")
        }
    }
    
}
