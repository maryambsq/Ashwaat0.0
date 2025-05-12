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
    
    //  This to make sure the app asks for notification permission when it launches :)
    init() {
        NotificationManager.shared.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            tawaf()
        }
        .modelContainer(sharedModelContainer)
    }
}
