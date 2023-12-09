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
    
    @StateObject var viewModel = HomeViewModel()
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                addTopBar()
                switch viewModel.selectedTabIndex {
                case 0:
                    CuriosityPhotoListView()
                case 1:
                    OpportunityPhotoListView()
                case 2:
                    SpiritPhotoListView()
                default:
                    CuriosityPhotoListView()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onTapFilter) {
                        Label("Filter", image: "filter")
                    }
                }
            }
        }
        
    }
    
    private func onTapFilter() {
        print("filter tapped")
    }
}

extension HomeView {
    func addTopBar() -> some View {
        CustomTopTabBar(tabs: viewModel.tabs, tabIndex: $viewModel.selectedTabIndex)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
