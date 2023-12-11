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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: viewModel.onTapFilter) {
                        Label("Filter", image: "filter")
                    }
                    .popover(isPresented: $viewModel.showFilters) {
                        FilterView(viewModel: viewModel, isPresenting: $viewModel.showFilters)
                    }
                }
            }
        }
    }
}

extension HomeView {
    func addTopBar() -> some View {
        CustomTopTabBar(tabs: viewModel.tabs, selectedTab: $viewModel.selectedTab)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
