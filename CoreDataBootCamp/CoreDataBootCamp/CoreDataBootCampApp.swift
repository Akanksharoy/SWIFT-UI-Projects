//
//  CoreDataBootCampApp.swift
//  CoreDataBootCamp
//
//  Created by Akanksha on 15/07/26.
//

import SwiftUI
import CoreData

@main
struct CoreDataBootCampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
