//
//  FilterViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 10/12/2023.
//

import Foundation

class FilterViewModel: ObservableObject {
    var selectedRover: RoverVehicle
    @Published var selectedCamera: CameraType?
    
    init(rover: RoverVehicle) {
        selectedRover = rover
    }
    
    
    func getCameras() -> [CameraType] {
        return selectedRover.cameras
    }
}
