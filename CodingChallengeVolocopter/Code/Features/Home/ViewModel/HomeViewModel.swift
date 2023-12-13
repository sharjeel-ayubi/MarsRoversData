//
//  HomeViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    let tabs = RoverVehicle.allCases
    @Published var selectedTab = RoverVehicle.curiosity
    @Published var showFilters = false
    @Published var selectedCameraFilter: CameraType?
    
    let curiosityViewModel = PhotoListViewModel(repository: CuriosityRepository())
    let opportunityViewModel = PhotoListViewModel(repository: OpportunityRepository())
    let spiritViewModel = PhotoListViewModel(repository: SpiritRepository())
    
    private let notificationManager: NotificationManager = NotificationManager.shared
    
    func handleOnAppear() {
        notificationManager.setTab = { tab in
            self.selectedTab = tab
        }
    }
    
    func requestNotificationPermissions() async {
        try? await notificationManager.requestAuthorization()
    }
    
    func sendNotification() async {
        await notificationManager.sendNotification()
    }
    
    func getCameras() -> [CameraType] {
        return selectedTab.cameras
    }
    
    func getSelectedCamera() -> CameraType? {
        switch selectedTab {
        case .curiosity:
            return curiosityViewModel.selectedFilter
        case .opportunity:
            return opportunityViewModel.selectedFilter
        case .spirit:
            return spiritViewModel.selectedFilter
        }
    }
    
    func setSelectedCamera(to camera: CameraType?) {
        selectedCameraFilter = camera
        switch selectedTab {
        case .curiosity:
            curiosityViewModel.selectedFilter = camera
        case .opportunity:
            opportunityViewModel.selectedFilter = camera
        case .spirit:
            spiritViewModel.selectedFilter = camera
        }
    }
    
    func getPhotoListViewModel() -> PhotoListViewModel {
        switch selectedTab {
        case .curiosity:
            return curiosityViewModel
        case .opportunity:
            return opportunityViewModel
        case .spirit:
            return spiritViewModel
        }
    }
    
    func onTapFilter() {
        selectedCameraFilter = getSelectedCamera()
        showFilters = true
    }
}
