//
//  OpportunityPhotosRequest.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

protocol OpportunityPhotosRequestProtocol {
    func getOpportunityPhotos(page: Int) async throws -> PhotosResponse
}

struct OpportunityPhotosRequest: NetworkService, OpportunityPhotosRequestProtocol {
    func getOpportunityPhotos(page: Int) async throws -> PhotosResponse {
        return try await sendRequest(endpoint: .opportunity(page: page), responseModel: PhotosResponse.self)
    }
}
