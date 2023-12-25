//
//  HomeViewModelTest.swift
//  CodingChallengeVolocopterTests
//
//  Created by Sharjeel Ayubi on 24/12/2023.
//

import XCTest

final class HomeViewModelTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = HomeViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testGetCameras() {
        viewModel.selectedTab = .opportunity
        let roverCameras = viewModel.getCameras()
        XCTAssertEqual(RoverVehicle.opportunity.cameras, roverCameras)
        XCTAssertEqual(RoverVehicle.opportunity.cameras.count, roverCameras.count)
    }
    
    func testGetSelectedCamera() {
        viewModel.selectedTab = .spirit
        var selectedCamera = viewModel.getSelectedCamera()
        
        XCTAssertNil(selectedCamera)
        viewModel.spiritViewModel.selectedFilter = .FHAZ
        selectedCamera = viewModel.getSelectedCamera()
        
        XCTAssertEqual(selectedCamera, .FHAZ)
    }
    
    func testSetSelectedCamera() {
        viewModel.selectedTab = .curiosity
        XCTAssertNil(viewModel.selectedCameraFilter)
        XCTAssertNil(viewModel.curiosityViewModel.selectedFilter)
        
        viewModel.setSelectedCamera(to: .NAVCAM)
        XCTAssertNotNil(viewModel.selectedCameraFilter)
        XCTAssertEqual(viewModel.selectedCameraFilter, .NAVCAM)
        XCTAssertEqual(viewModel.curiosityViewModel.selectedFilter, .NAVCAM)
    }
    
    func testGetPhotoListViewModel() {
        viewModel.selectedTab = .opportunity
        XCTAssertNotNil(viewModel.getPhotoListViewModel())
        if viewModel.getPhotoListViewModel() === viewModel.opportunityViewModel {
            XCTAssertTrue(true)
        }
    }
    
    func testOnTapFilter() {
        XCTAssertFalse(viewModel.showFilters)
        viewModel.onTapFilter()
        XCTAssertEqual(viewModel.selectedCameraFilter, viewModel.getSelectedCamera())
        XCTAssertTrue(viewModel.showFilters)
        
    }
}
