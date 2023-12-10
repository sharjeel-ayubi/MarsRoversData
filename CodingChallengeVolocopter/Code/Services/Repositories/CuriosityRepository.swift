//
//  CuriosityRepository.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 16/11/2023.
//

import Foundation
import Combine

final class CuriosityRepository: RepositoryProtocol {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    func getPhotos(page: Int) -> AnyPublisher<PhotosResponse, NetworkError> {
        let request = CuriosityPhotosRequest(page: page)
        return networkService.request(request)
    }
}
