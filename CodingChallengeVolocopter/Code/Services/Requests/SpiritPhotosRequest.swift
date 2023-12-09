//
//  SpiritPhotosRequest.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

protocol SpiritPhotosRequestProtocol {
    func getSpiritPhotos(page: Int) async throws -> PhotosResponse
}

struct SpiritPhotosRequest: NetworkService, SpiritPhotosRequestProtocol {
    func getSpiritPhotos(page: Int) async throws -> PhotosResponse {
        return try await sendRequest(endpoint: .spirit(page: page), responseModel: PhotosResponse.self)
    }
}
