//
//  CoreDataStack.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 19.05.2024.
//

import CoreData
import Foundation

// 🚨 Define an observable class to encapsulate all Core Data-related functionality.
class CoreDataStack: ObservableObject {
    
    static let shared = CoreDataStack()
    
    // 🚨 Create a persistent container as a lazy variable to defer instantiation until its first use.
    lazy var persistentContainer: NSPersistentContainer = {
        
        // 🚨 That tells Core Data we want to use the "DataModel" data model.
        // -> It doesn’t actually load it – we’ll do that in a moment – but it does prepare Core Data to load it.
        // -> Data models don’t contain our actual data, just the definitions of properties and attributes like we defined a moment ago.
        let container = NSPersistentContainer(name: "DataModel")
        
        
        // 🚨 Load any persistent stores, which creates a store if none exists.
        // -> To actually load the data model we need to call loadPersistentStores() on our container, which tells Core Data to access our saved data according to the data model in DataModel.xcdatamodeld.
        container.loadPersistentStores { _, error in
            if let error {
                // Handle the error appropriately. However, it's useful to use
                // fatalError(_:file:line:) during development.
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private init(){ }
}
