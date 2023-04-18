//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Oliwier Kasprzak on 18/04/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    let dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
