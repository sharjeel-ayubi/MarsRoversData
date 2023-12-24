//
//  PhotoCameraEntity+CoreDataProperties.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 22/12/2023.
//
//

import Foundation
import CoreData


extension PhotoCameraEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoCameraEntity> {
        return NSFetchRequest<PhotoCameraEntity>(entityName: "PhotoCameraEntity")
    }

    @NSManaged public var fullname: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var roverID: Int32
    @NSManaged public var ofPhoto: PhotoEntity?

}

extension PhotoCameraEntity : Identifiable {

}
