//
//  Ashwaat0_0App.swift
//  Ashwaat0.0
//
//  Created by Maryam Amer Bin Siddique on 01/11/1446 AH.
//

import SwiftUI
import SwiftData

@main
struct Ashwaat0_0App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
