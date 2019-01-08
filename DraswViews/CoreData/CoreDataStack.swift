//
//  CoreDataStack.swift
//  DraswViews
//
//  Created by Badarinath Venkatnarayansetty on 1/7/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DraswViews")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        guard managedObjectContext.hasChanges || savedManagedObjectContext.hasChanges else { return }
        
        //Need to save in two parts
        
        //on main queue and it will be synchronous
        managedObjectContext.performAndWait {
            do{
              try managedObjectContext.save()
            }catch let error {
                fatalError("Error while saving the managed Object \(error.localizedDescription)")
            }
        }
        
        //asynchronous
        savedManagedObjectContext.perform {
            do{
                try self.savedManagedObjectContext.save()
            }catch let error {
                fatalError("Error while saving the managed Object \(error)")
            }
        }
    }
    
    lazy var savedManagedObjectContext: NSManagedObjectContext = {
        let objectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        objectContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        return objectContext
    }()
    
    lazy var managedObjectContext:NSManagedObjectContext = {
        let objectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        objectContext.parent = self.savedManagedObjectContext
        return objectContext
    }()
    
    //adding the data
    func saveData(name: String) {
        guard let deviceEntity = NSEntityDescription.entity(forEntityName: "Devices", in: managedObjectContext) else { return }
        let managedObject = NSManagedObject(entity: deviceEntity, insertInto: managedObjectContext)
        managedObject.setValue(name, forKey: "name")
        self.saveContext()
    }
    
    //read from Core Data
    func read<T:NSManagedObject>(T: T.Type) -> [T] {
        var devices:[T] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(T.self)")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            devices = try managedObjectContext.fetch(fetchRequest) as! [T]
            print(devices)
        }catch let error {
            fatalError("Failed to execute Fetch Request \(error)")
        }
        
        return devices
    }
    
    //read using fetch Results Controller
    func readUsingFetchResultsController<T:NSManagedObject>(T: T.Type) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(T.self)")
        
        let fetchResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do{
           try fetchResults.performFetch()
        }catch let error {
            fatalError("Failed to Fetch \(error)")
        }
        
        let objects = fetchResults.fetchedObjects as! [T]
        
        return objects
    }

}
