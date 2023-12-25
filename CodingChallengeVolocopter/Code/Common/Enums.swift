//
//  Enums.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

import Foundation

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

enum AppError: Error, Equatable, AppErrorProtocol {
    //just to make it identifiable
    var id: String { UUID().uuidString }
    
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
    case readError(_ error: String)
    case writeError(_ error: String)
    case deleteError(_ error: String)
    case inconsistentState
    
    var title: String {
        switch self {
        default:
            return "Error"
        }
    }

    var errorDescription: String {
        switch self {
        case .badURL(let error):
            return error
        case .apiError(_, let error):
            return error
        case .invalidJSON(let error):
            return error
        case .unauthorized(_, let error):
            return error
        case .badRequest(_, let error):
            return error
        case .serverError(_, let error):
            return error
        case .noResponse(let error):
            return error
        case .unableToParseData(let error):
            return error
        case .unknown(_, let error):
            return error
        case .readError(let error):
            return error
        case .writeError(let error):
            return error
        case .deleteError(let error):
            return error
        case .inconsistentState:
            return "Something went wrong"
        }
    }
}
