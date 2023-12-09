//
//  OpportunityRepository.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 08/12/2023.
//

import Foundation

class OpportunityRepository: PhotosRepositoryProtocol {
    
    typealias NetworkRequest = OpportunityPhotosRequest
    
    var request: OpportunityPhotosRequest
    
    required init(request: OpportunityPhotosRequest) {
        self.request = request
    }
    
    func getPhotos(page: Int) async throws -> PhotosResponse {
        let photosResponse = try await request.getOpportunityPhotos(page: page)
        return photosResponse
    }
    
}
