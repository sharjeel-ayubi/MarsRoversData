//
//  SpiritRepository.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 08/12/2023.
//

import Foundation

class SpiritRepository: PhotosRepositoryProtocol {
    
    typealias NetworkRequest = SpiritPhotosRequest
    
    var request: SpiritPhotosRequest
    
    required init(request: SpiritPhotosRequest) {
        self.request = request
    }
    
    func getPhotos(page: Int) async throws -> PhotosResponse {
        let photosResponse = try await request.getSpiritPhotos(page: page)
        return photosResponse
    }
    
}
