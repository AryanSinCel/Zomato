//
//  Persistence.swift
//  MVVMCoreData
//
//  Created by Celestial on 07/02/25.
//

import SwiftUI
import CoreData

struct PersistenceController{
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "Zomato")
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
}
