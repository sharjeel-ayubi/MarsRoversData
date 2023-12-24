//
//  RoverEntity+CoreDataProperties.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 22/12/2023.
//
//

import Foundation
import CoreData


extension RoverEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoverEntity> {
        return NSFetchRequest<RoverEntity>(entityName: "RoverEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var landingDate: String?
    @NSManaged public var launchDate: String?
    @NSManaged public var name: String?
    @NSManaged public var ofPhoto: PhotoEntity?

}

extension RoverEntity : Identifiable {

}
