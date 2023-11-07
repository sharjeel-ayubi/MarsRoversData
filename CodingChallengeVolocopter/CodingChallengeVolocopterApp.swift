//
//  CodingChallengeVolocopterApp.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 07/11/2023.
//

import SwiftUI

@main
struct CodingChallengeVolocopterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
