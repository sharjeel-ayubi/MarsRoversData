//
//  PhotoEntity+CoreDataProperties.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 22/12/2023.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var earthDate: String?
    @NSManaged public var id: Int32
    @NSManaged public var imgSrc: String?
    @NSManaged public var sol: Int32
    @NSManaged public var createdAt: Date?
    @NSManaged public var camera: PhotoCameraEntity?
    @NSManaged public var rover: RoverEntity?

}

extension PhotoEntity : Identifiable {

}
