//
//  FilterViewModelTests.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 25/12/2023.
//

import XCTest

final class FilterViewModelTests: XCTestCase {

    var viewModel: FilterViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = FilterViewModel(rover: .opportunity)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testGetCameras() {
        let cameras = viewModel.getCameras()
        XCTAssertEqual(RoverVehicle.opportunity.cameras, cameras)
        XCTAssertEqual(RoverVehicle.opportunity.cameras.count, cameras.count)
    }
}
