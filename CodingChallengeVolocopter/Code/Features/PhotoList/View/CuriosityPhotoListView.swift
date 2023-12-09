//
//  PhotoListView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

import SwiftUI

struct CuriosityPhotoListView: View {
    
    @StateObject var viewModel = CuriosityPhotoListViewModel()
    
    private let cellSpacing: CGFloat = 8
    private var cellDimension: CGFloat = 0
    private var columns: [GridItem] = []
    
    @State private var selectedPhoto: Photo? = nil
    
    init() {
        self.cellDimension = (UIScreen.main.bounds.width/2)-cellSpacing
        self.columns = [GridItem(.fixed(cellDimension), spacing: cellSpacing),
                        GridItem(.fixed(cellDimension), spacing: cellSpacing)]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.photos, id: \.id) { photo in
                    AsyncImage(url: URL(string:photo.imgSrc)) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: (cellDimension))
                    .onAppear {
                        // Load more photos when reaching the last item
                        if photo.id == viewModel.photos.last?.id {
                            loadMorePhotos()
                        }
                    }
                    .onTapGesture {
                        selectedPhoto = photo
                    }
                    .sheet(item: $selectedPhoto) { photo in
                        PhotoDetailView(photo: photo)
                            .presentationDragIndicator(.visible)
                    }
                    
                }
            }
            .onAppear {
                loadMorePhotos()
            }
        }
        .refreshable {
            loadMorePhotos(isForceLoading: true)
        }
        
    }
    
    func loadMorePhotos(isForceLoading: Bool = false) {
        Task {
            await viewModel.fetchPhotos(isForceLoading: isForceLoading)
        }
    }
    
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        CuriosityPhotoListView()
    }
}

