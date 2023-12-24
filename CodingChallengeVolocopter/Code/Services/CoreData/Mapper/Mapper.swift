//
//  Mapper.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 19/12/2023.
//

import Foundation

extension PhotoEntity {
    func encode(entity: Photo) {
        self.id = Int32(entity.id)
        self.sol = Int32(entity.sol)
        self.earthDate = entity.earthDate
        self.imgSrc = entity.imgSrc
        self.createdAt = Date()
        
        guard let context = self.managedObjectContext else { return }
        let roverEntity = RoverEntity(context: context)
        roverEntity.encode(entity: entity.rover)
        self.rover = roverEntity
        
        let cameraEntity = PhotoCameraEntity(context: context)
        cameraEntity.encode(entity: entity.camera)
        self.camera = cameraEntity
        
    }
    func decode() -> Photo {
        let photoCamera = PhotoCamera(id: Int(self.camera?.id ?? 0),
                                      name: self.camera?.name ?? "",
                                      roverID: Int(self.camera?.roverID ?? 0),
                                      fullName: self.camera?.fullname ?? "")
        let rover = Rover(id: Int(self.rover?.id ?? 0),
                          name: self.rover?.name ?? "",
                          landingDate: self.rover?.landingDate ?? "",
                          launchDate: self.rover?.launchDate ?? "")
        return Photo(id: Int(id),
                     sol: Int(sol),
                     camera: photoCamera,
                     imgSrc: imgSrc ?? "",
                     earthDate: earthDate ?? "",
                     rover: rover)
    }
}


extension RoverEntity {
    func encode(entity: Rover) {
        self.id = Int32(entity.id)
        self.name = entity.name
        self.launchDate = entity.launchDate
        self.landingDate = entity.landingDate
    }
    func decode() -> Rover {
        return Rover(id: Int(self.id),
                     name: self.name ?? "",
                     landingDate: self.landingDate ?? "",
                     launchDate: self.launchDate ?? "")
    }
}

extension PhotoCameraEntity {
    func encode(entity: PhotoCamera) {
        self.id = Int32(entity.id)
        self.name = entity.name
        self.fullname = entity.fullName
        self.roverID = Int32(entity.roverID)
    }
    
    func decode() -> PhotoCamera {
        return PhotoCamera(id: Int(self.id),
                           name: self.name ?? "",
                           roverID: Int(self.roverID),
                           fullName: self.fullname ?? "")
    }
}
