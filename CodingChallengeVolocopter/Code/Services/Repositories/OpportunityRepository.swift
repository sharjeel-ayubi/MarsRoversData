//
//  OpportunityRepository.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 08/12/2023.
//

import Foundation
import Combine

final class OpportunityRepository: RepositoryProtocol {
    
    let networkService: NetworkService
    let persistence: PersistenceQueryObject
    private let roverName = RoverVehicle.opportunity.name
    
    init(networkService: NetworkService = DefaultNetworkService(),
         persistence: PersistenceQueryObject = PhotoDAO()) {
        self.networkService = networkService
        self.persistence = persistence
    }
    
    func getPhotos(page: Int, filter: String = "") -> AnyPublisher<[Photo], AppError> {
        if NetworkMonitor.shared.isInternetConnected() {
            return fetchNetworkPhotos(page: page, filter: filter)
                .map { [weak self] photosResponse in
                    for photo in photosResponse.photos {
                        _ = self?.add(photo: photo)
                    }
                    return photosResponse.photos
                }
                .catch { error -> AnyPublisher<[Photo], AppError> in
                    //If failed to fetch from network, fetch from persistence
                    return self.fetchPersistencePhotos(with: filter, page: page)
                }.eraseToAnyPublisher()
        } else {
            return self.fetchPersistencePhotos(with: filter, page: page)
        }
    }
}

//MARK: Fetch Methods
extension OpportunityRepository {
    private func fetchPersistencePhotos(with filter: String, page: Int) -> AnyPublisher<[Photo], AppError> {
        getAll(with: filter, page: page)
    }
    
    private func fetchNetworkPhotos(page: Int, filter: String) -> AnyPublisher<PhotosResponse, AppError> {
        let request = OpportunityPhotosRequest(page: page, filter: filter)
        return networkService.request(request)
    }
}

//MARK: CRUD Methods
extension OpportunityRepository {
    private func add(photo: Photo) {
        _ = persistence.add(photo)
    }
    
    private func getAll(with filter: String, page: Int) -> AnyPublisher<[Photo], AppError> {
        self.persistence.getAll(withRover: roverName, andCamera: filter, page: page)
    }

    private func update(photo: Photo) {
        _ = persistence.updateOrAdd(photo)
    }

    private func delete(photo: Photo) {
        _ = persistence.delete(photo)
    }

    private func deleteAllPhotos() {
        _ = persistence.deleteAll(withRover: nil, andCamera: nil)
    }
}
