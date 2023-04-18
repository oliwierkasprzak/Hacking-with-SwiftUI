//
//  DataController.swift
//  CoreDataProject
//
//  Created by Oliwier Kasprzak on 18/04/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump 
    }
}
