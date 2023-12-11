//
//  SpiritRepository.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 08/12/2023.
//

import Foundation
import Combine

final class SpiritRepository: RepositoryProtocol {
    
    let networkService: NetworkService
    
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    func getPhotos(page: Int, filter: String = "") -> AnyPublisher<PhotosResponse, NetworkError> {
        let request = SpiritPhotosRequest(page: page, filter: filter)
        return networkService.request(request)
    }
}
