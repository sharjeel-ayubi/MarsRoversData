//
//  Persistence.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 07/11/2023.
//

import CoreData

//Storage layer is abstracted so that in future it can be injected with different storage mechanism (Realm, UserDefault)
protocol Persistence {
    associatedtype PersistentContainer
    associatedtype ManagedContext
    
    var persistentContainer: PersistentContainer { get }
    var mainContext: ManagedContext { get }
    var taskContext: ManagedContext { get }
    
    func saveContext()
    func saveContext(_ context: ManagedContext)
}

struct CoreDataPersistence: Persistence {
    
    typealias PersistentContainer = NSPersistentContainer
    typealias ManagedContext = NSManagedObjectContext
    
    static let shared = CoreDataPersistence()
    static let sharedTest = CoreDataPersistence(inMemory: true)
    
    let persistentContainer: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var taskContext: ManagedContext {
        
        let context = self.persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        context.undoManager = nil
        
        return context
    }
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "CodingChallengeVolocopter")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        let context = mainContext
        
        // Save all the changes just made and reset the context to free the cache.
        context.performAndWait {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            // Reset the context to clean up the cache and low the memory footprint.
            context.reset()
        }
    }
    
    func saveContext(_ context: NSManagedObjectContext) {
        guard context != mainContext else {
            saveContext()
            return
        }
        
        context.performAndWait {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            self.saveContext(self.mainContext)
        }
    }
}
