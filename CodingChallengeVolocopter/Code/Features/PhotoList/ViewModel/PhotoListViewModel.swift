//
//  PhotoListViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 11/12/2023.
//

import Foundation
import Combine

class PhotoListViewModel: ObservableObject {
    @Published var page: Int = 0
    @Published var filteredPage: Int = 0
    @Published var isLoading: Bool = false
    @Published var photos: [Photo] = []
    var filteredPhotos: [Photo] = []
    var result: [Photo] = []
    @Published var error: NetworkError?
    @Published var selectedFilter: CameraType?
    
    var repository: RepositoryProtocol
    var cancellable = Set<AnyCancellable>()
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
}

//MARK: Helping Methods
extension PhotoListViewModel {
    func handleOnAppear() {
        guard photos.isEmpty else {return}
        fetchPhotos()
    }
    
    private func updatePhotos() {
        if selectedFilter != nil {
            photos = filteredPhotos
        } else {
            photos = result
        }
    }
}

//MARK: API Calls to fetch Photos
extension PhotoListViewModel {
    func fetchPhotos(isForceLoading: Bool = false) {
        if let selectedFilter = selectedFilter {
            fetchFilteredPhotos(isForceLoading: isForceLoading, camera: selectedFilter)
        } else {
            fetchAllPhotos(isForceLoading: isForceLoading)
        }
    }
    
    private func fetchAllPhotos(isForceLoading: Bool) {
        guard !isLoading else { return }
        isLoading = true
        if isForceLoading {
            result.removeAll()
            page = 0
        }
        page += 1
        
        repository.getPhotos(page: page, filter: "")
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                    self.error = error
                case .finished:
                    self.isLoading = false
                }
            } receiveValue: { (response) in
                self.result.append(contentsOf: response.photos)
                self.updatePhotos()
            }
            .store(in: &cancellable)
        
    }
    
    private func fetchFilteredPhotos(isForceLoading: Bool = false, camera: CameraType) {
        guard !isLoading else { return }
        isLoading = true
        if isForceLoading {
            filteredPhotos.removeAll()
            filteredPage = 0
        }
        filteredPage += 1
        
        repository.getPhotos(page: filteredPage, filter: camera.rawValue)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("oops got an error \(error.localizedDescription)")
                    self.error = error
                case .finished:
                    self.isLoading = false
                }
            } receiveValue: { (response) in
                self.filteredPhotos.append(contentsOf: response.photos)
                self.updatePhotos()
            }
            .store(in: &cancellable)
    }
}
