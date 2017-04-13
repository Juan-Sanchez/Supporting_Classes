//
//  TempCoreDataStack.swift
//  Created by juan sanchez on 4/12/17.
//

import Foundation
import CoreData

class TempCoreDataStack {
    
    fileprivate var context: NSManagedObjectContext?
    
    init() {
        context = nil
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            
            context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context?.persistentStoreCoordinator = persistentStoreCoordinator
            
            print("TempCoreDataStack successfully created in memory store")
        } catch {
            print("ERROR: TempCoreDataStack failed to create in memory store")
        }
    }
    
    func getContext() -> NSManagedObjectContext? {
        return self.context
    }
    
}
