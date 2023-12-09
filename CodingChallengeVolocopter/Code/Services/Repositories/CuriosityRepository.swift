//
//  CuriosityRepository.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 16/11/2023.
//

import Foundation

class CuriosityRepository: PhotosRepositoryProtocol {
    
    typealias NetworkRequest = CuriosityPhotosRequest
    
    var request: CuriosityPhotosRequest
    
    required init(request: CuriosityPhotosRequest) {
        self.request = request
    }
    
    func getPhotos(page: Int) async throws -> PhotosResponse {
        let photosResponse = try await request.getCuriosityPhotos(page: page)
        return photosResponse
    }
    
}
