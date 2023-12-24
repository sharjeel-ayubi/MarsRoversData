//
//  CodingChallengeVolocopterApp.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 07/11/2023.
//

import SwiftUI

@main
struct CodingChallengeVolocopterApp: App {
    let coreDataPersistence = CoreDataPersistence.shared

    init() {
        let cache = URLCache(
            memoryCapacity: 4 * 1024 * 1024,  // 4 MB
            diskCapacity: 500 * 1024 * 1024,   // 500 MB
            diskPath: "volocopter_cache"
        )
        URLCache.shared = cache
    }
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
                .environment(\.managedObjectContext, coreDataPersistence.persistentContainer.viewContext)
        }
    }
}
