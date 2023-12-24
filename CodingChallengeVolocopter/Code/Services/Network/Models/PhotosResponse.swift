//
//  PhotosResponse.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

struct PhotosResponse: Codable {
    let photos: [Photo]
    enum CodingKeys: String, CodingKey {
        case photos
    }
}

//MARK: - Photo
struct Photo: Codable, Persistable {
    var id: Int
    let sol: Int
    let camera: PhotoCamera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

//MARK: - PhotoCamera
struct PhotoCamera: Codable, Persistable {
    var id: Int
    let name: String
    let roverID: Int
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

//MARK: - Rover
struct Rover: Codable, Persistable {
    var id: Int
    let name, landingDate, launchDate: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
    }
}
