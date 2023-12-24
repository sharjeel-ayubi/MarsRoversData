//
//  ContentView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 07/11/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                addTopBar()
                switch viewModel.selectedTab {
                case .curiosity:
                    PhotoListView(viewModel: viewModel.curiosityViewModel)
                case .opportunity:
                    PhotoListView(viewModel: viewModel.opportunityViewModel)
                case .spirit:
                    PhotoListView(viewModel: viewModel.spiritViewModel)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    notificationButton()
                    filterButton()
                }
            }
        }
        .task {
            await viewModel.requestNotificationPermissions()
        }
        .onAppear {
            viewModel.handleOnAppear()
        }
    }
}

extension HomeView {
    func addTopBar() -> some View {
        CustomTopTabBar(tabs: viewModel.tabs, selectedTab: $viewModel.selectedTab)
    }
    
    func filterButton() -> some View {
        Button(action: viewModel.onTapFilter) {
            Label("Filter", image: "filter")
        }
        .popover(isPresented: $viewModel.showFilters) {
            FilterView(viewModel: viewModel, isPresenting: $viewModel.showFilters)
        }
    }
    
    func notificationButton() -> some View {
        Button(action: {
            Task {
                await viewModel.sendNotification()
            }
        }) {
            Image(systemName: "bell.fill")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel()).environment(\.managedObjectContext, CoreDataPersistence.shared.persistentContainer.viewContext)
    }
}
