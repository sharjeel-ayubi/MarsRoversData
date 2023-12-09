//
//  HomeViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    let tabs = Tabs.allCases
    @Published var selectedTabIndex = 0
}
