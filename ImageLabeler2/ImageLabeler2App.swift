//
//  ImageLabeler2App.swift
//  ImageLabeler2
//
//  Created by Christopher Yoon on 4/28/24.
//

import SwiftUI
import SwiftData

@main
struct ImageLabeler2App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self, DataModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            NavigationStack{
                DataListView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
