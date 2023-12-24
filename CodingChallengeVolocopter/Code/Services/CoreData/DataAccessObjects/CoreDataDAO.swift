//
//  CoreDataDAO.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 19/12/2023.
//

import Foundation
import Combine
import CoreData

class CoreDataDAO<Entity: Persistable, ManagedObject: NSManagedObject>: BaseDAO {
    
    typealias Storage = CoreDataPersistence
    
    var storage: Storage
    
    required init(storage: Storage = CoreDataPersistence.shared) {
        self.storage = storage
    }
    
    /// Generates Element Request for finding a specific object in database
    func generateElementRequest(_ entity: Entity) -> NSFetchRequest<ManagedObject> {
        let request = ManagedObject.fetchRequest() as! NSFetchRequest<ManagedObject>
        let predicate = NSPredicate(format: "id = %ld", entity.id)
        request.predicate = predicate
        return request
    }
    
    /// Generates Array Request for retrieving all existing objects in database
    func generateArrayRequest(forRover roverName: String? = nil, andCamera cameraType: String? = nil, page: Int? = nil) -> NSFetchRequest<ManagedObject> {
        let request = ManagedObject.fetchRequest() as! NSFetchRequest<ManagedObject>
        
        var predicates: [NSPredicate] = []
        
        // Adding predicate for rover name
        if let roverName = roverName, !roverName.isEmpty {
            let roverPredicate = NSPredicate(format: "rover.name = %@", roverName)
            predicates.append(roverPredicate)
        }
        
        // Adding predicate for camera name
        if let cameraType = cameraType, !cameraType.isEmpty {
            let cameraPredicate = NSPredicate(format: "camera.name = %@", cameraType)
            predicates.append(cameraPredicate)
        }
        
        // Combining predicates with AND
        if !predicates.isEmpty {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.predicate = compoundPredicate
        }
        if let page = page {
            request.fetchLimit = PhotosAPI.pageSize
            if page > 1 {
                request.fetchOffset = (page-1)*PhotosAPI.pageSize
            }
        }
        
        if let sortDescriptors = self.sortDescriptors {
            request.sortDescriptors = sortDescriptors
        }
        return request
    }
    
    // This function adds an Entity if does not exists on the model or on the contrary updates it
    func updateOrAdd(_ entity: Entity) -> AnyPublisher<Entity, AppError> {
        let backgroundContext = storage.taskContext
        let request = self.generateElementRequest(entity)
        var updatedEntity: Entity!
        
        return Future<Entity, AppError> { promise in
            
            backgroundContext.performAndWait {
                
                let results = try? backgroundContext.fetch(request)
                
                var coreDataObject: ManagedObject
                
                if results?.count == 0 {
                    // Creating Entity
                    coreDataObject = ManagedObject(context: backgroundContext)
                } else {
                    // Updating Entity
                    coreDataObject = results!.first!
                }
                self.encode(entity: entity, into: &coreDataObject)
                updatedEntity = self.decode(object: coreDataObject)
                self.storage.saveContext(backgroundContext)
                promise(.success(updatedEntity))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    //This function adds the entity if it doesnot exist already
    func add(_ entity: Entity) -> AnyPublisher<Entity, AppError> {
        let backgroundContext = storage.taskContext
        let request = self.generateElementRequest(entity)
        var addedEntity: Entity!
        
        return Future<Entity, AppError> { promise in
            
            backgroundContext.performAndWait {
                
                let results = try? backgroundContext.fetch(request)
                
                //does not add if already existed
                if results?.count == 0 {
                    // Creating Entity
                    var coreDataObject = ManagedObject(context: backgroundContext)
                    self.encode(entity: entity, into: &coreDataObject)
                    addedEntity = self.decode(object: coreDataObject)
                    self.storage.saveContext(backgroundContext)
                    promise(.success(addedEntity))
                } else {
                    promise(.failure(AppError.inconsistentState))
                }
                
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func getAll(withRover rover: String? = nil, andCamera camera: String? = nil, page: Int? = nil) -> AnyPublisher<[Entity], AppError> {
        
        let backgroundContext = storage.taskContext
        let request = generateArrayRequest(forRover: rover, andCamera: camera, page: page)
        
        return Future<[Entity], AppError> { promise in
            backgroundContext.performAndWait {
                do {
                    let result = try backgroundContext.fetch(request)
                    let entities = result.map{
                        self.decode(object: $0)
                    }
                    promise(.success(entities))
                } catch (let error){
                    promise(.failure(AppError.readError(error.localizedDescription)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func delete(_ entity: Entity) -> AnyPublisher<Bool, AppError> {
        
        let backgroundContext = storage.taskContext
        let request = self.generateElementRequest(entity)
        return Future<Bool, AppError> { promise in
            backgroundContext.performAndWait {
                do {
                    let result = try backgroundContext.fetch(request)
                    
                    if let object = result.last {
                        guard result.count == 1 else {
                            promise(.failure(AppError.inconsistentState))
                            return
                        }
                        backgroundContext.delete(object)
                        self.storage.saveContext(backgroundContext)
                        promise(.success(true))
                    } else {
                        promise(.failure(AppError.readError("Entity Could Not Be Read")))
                    }
                } catch (let error) {
                    promise(.failure(AppError.readError(error.localizedDescription)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func deleteAll(withRover rover: String? = nil, andCamera camera: String? = nil) -> AnyPublisher<Bool, AppError> {
        
        let backgroundContext = storage.taskContext
        let request = self.generateArrayRequest(forRover: rover, andCamera: camera)
        return Future<Bool, AppError> { promise in
            backgroundContext.performAndWait {
                do {
                    try backgroundContext.fetch(request)
                        .forEach { entity in
                            backgroundContext.delete(entity)
                        }
                    self.storage.saveContext(backgroundContext)
                    promise(.success(true))
                } catch {
                    promise(.failure(AppError.readError(error.localizedDescription)))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    // MARK: - OVERRIDABLE
    var sortDescriptors: [NSSortDescriptor]? {
        return nil
    }
    
    func encode(entity: Entity, into object: inout ManagedObject) {
        fatalError("""
                    no encoding provided \(String(describing: Entity.self)) - \(String(describing: ManagedObject.self))
                    """)
    }
    
    func decode(object: ManagedObject) -> Entity {
        fatalError("""
                   no decoding provided between core data entity:
                   \(String(describing: ManagedObject.self))
                   and domain entity: \(String(describing: Entity.self))
                   """)
    }
}

