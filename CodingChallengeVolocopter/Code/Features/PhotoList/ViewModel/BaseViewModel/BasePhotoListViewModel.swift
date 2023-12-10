//
//  BasePhotoListViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 10/12/2023.
//

import Foundation
import Combine

protocol BasePhotoListViewModel: ObservableObject {
    
    var page: Int { get set }
    var isLoading: Bool { get set }
    var photos:[Photo] { get set }
    var error: NetworkError? { get set }
    
    var repository: RepositoryProtocol { get set }
    var cancellable: Set<AnyCancellable> { get set }
    
    func fetchPhotos(isForceLoading: Bool)
}

extension BasePhotoListViewModel {
    func fetchPhotos(isForceLoading: Bool = false) {
        guard !isLoading else { return }
        isLoading = true
        if isForceLoading {
            photos.removeAll()
            page = 0
        }
        page += 1
        
        repository.getPhotos(page: page)
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
                self.photos.append(contentsOf: response.photos)
            }
            .store(in: &cancellable)
        
    }
}
