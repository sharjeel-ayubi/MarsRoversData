//
//  PhotoListViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 14/11/2023.
//

import Foundation

@MainActor
class CuriosityPhotoListViewModel: ObservableObject {
    
    @Published var page: Int = 0
    @Published var isLoading: Bool = false
    @Published var photos: [Photo] = []
    
    var repository: any PhotosRepositoryProtocol
    
    init(repository: any PhotosRepositoryProtocol = CuriosityRepository(request: CuriosityPhotosRequest())) {
        self.repository = repository
    }
    
    func fetchPhotos(isForceLoading: Bool = false) async {
        do {
            guard !isLoading else { return }
            isLoading = true
            if isForceLoading {
                photos.removeAll()
                page = 0
            }
            page += 1
            
            let photosResponse = try await repository.getPhotos(page: page)
            self.photos.append(contentsOf: photosResponse.photos)
            isLoading = false
            
        } catch NetworkError.offline {
            self.isLoading = false
        } catch {
            self.isLoading = false
        }
    }
}
