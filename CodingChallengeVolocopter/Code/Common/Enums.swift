//
//  Enums.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

//MARK: - Rover Enums
enum CameraType: String, CaseIterable {
    case FHAZ
    case RHAZ
    case MAST
    case CHEMCAM
    case MAHLI
    case MARDI
    case NAVCAM
    case PANCAM
    case MINITES
    
    var fullname: String {
        switch self {
        case .FHAZ:
            return "Front Hazard Avoidance Camera"
        case .RHAZ:
            return "Rear Hazard Avoidance Camera"
        case .MAST:
            return "Mast Camera"
        case .CHEMCAM:
            return "Chemistry and Camera Complex"
        case .MAHLI:
            return "Mars Hand Lens Imager"
        case .MARDI:
            return "Mars Descent Imager"
        case .NAVCAM:
            return "Navigation Camera"
        case .PANCAM:
            return "Panoramic Camera"
        case .MINITES:
            return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        }
    }
}

enum RoverVehicle: String, CaseIterable {
    case curiosity
    case opportunity
    case spirit
    
    var name: String {
        switch self {
        case .curiosity:
            return "Curiosity"
        case .opportunity:
            return "Opportunity"
        case .spirit:
            return "Spirit"
        }
    }
    
    var cameras: [CameraType] {
        var allCameras = CameraType.allCases
        switch self {
        case .curiosity:
            allCameras.removeAll { camera in
                return camera == .PANCAM || camera == .MINITES
            }
            return allCameras
        case .opportunity, .spirit:
            allCameras.removeAll { camera in
                return camera == .MAST || camera == .CHEMCAM || camera == .MAHLI || camera == .MARDI
            }
            return allCameras
        }
    }
}

//MARK: - Network Enums
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}
