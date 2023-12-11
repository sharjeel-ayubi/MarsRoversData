//
//  PhotoListView.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 09/11/2023.
//

import SwiftUI

struct PhotoListView: View {
    
    @ObservedObject var viewModel: PhotoListViewModel
    @State private var selectedPhoto: Photo? = nil
    
    private let cellSpacing: CGFloat = 8
    private var cellDimension: CGFloat = 0
    private var columns: [GridItem] = []
    
    init(viewModel: PhotoListViewModel) {
        self.viewModel = viewModel
        self.cellDimension = (UIScreen.main.bounds.width/2)-cellSpacing
        self.columns = [GridItem(.fixed(cellDimension), spacing: cellSpacing),
                        GridItem(.fixed(cellDimension), spacing: cellSpacing)]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                generatePhotoListView()
            }
            .task {
                viewModel.handleOnAppear()
            }
        }
        .refreshable {
            viewModel.fetchPhotos(isForceLoading: true)
        }
    }
}

extension PhotoListView {
    func generatePhotoListView() -> some View {
        ForEach(viewModel.photos, id: \.id) { photo in
            AsyncImage(url: URL(string:photo.imgSrc)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(height: (cellDimension))
            .onAppear {
                // Load more photos when reaching the last item
                if photo.id == viewModel.photos.last?.id {
                    viewModel.fetchPhotos()
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
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(viewModel: PhotoListViewModel(repository: CuriosityRepository()))
    }
}

