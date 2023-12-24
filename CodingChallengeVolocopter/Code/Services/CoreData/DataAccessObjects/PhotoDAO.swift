//
//  PhotoDAO.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 19/12/2023.
//

import Foundation
import Combine
import CoreData

protocol PersistenceQueryObject {
    func updateOrAdd(_ entity: Photo) -> AnyPublisher<Photo, AppError>
    func add(_ entity: Photo) -> AnyPublisher<Photo, AppError>
    func getAll(withRover rover:String?, andCamera camera: String?, page: Int?) -> AnyPublisher<[Photo], AppError>
    func delete(_ entity: Photo) -> AnyPublisher<Bool, AppError>
    func deleteAll(withRover rover:String?, andCamera camera: String?) -> AnyPublisher<Bool, AppError>
}

class PhotoDAO: CoreDataDAO<Photo, PhotoEntity>, PersistenceQueryObject {
    
    override func encode(entity: Photo, into object: inout PhotoEntity) {
        object.encode(entity: entity)
    }
    
    override func decode(object: PhotoEntity) -> Entity {
        return object.decode()
    }
    
    override var sortDescriptors: [NSSortDescriptor]? {
        return [
            NSSortDescriptor(keyPath: \PhotoEntity.createdAt, ascending: true)
        ]
    }
}
