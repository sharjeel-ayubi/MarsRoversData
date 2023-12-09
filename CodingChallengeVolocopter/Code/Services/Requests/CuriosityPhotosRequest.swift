//
//  CuriosityPhotosRequest.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/11/2023.
//

import Foundation

protocol CuriosityPhotosRequestProtocol {
    func getCuriosityPhotos(page: Int) async throws -> PhotosResponse
}

struct CuriosityPhotosRequest: NetworkService, CuriosityPhotosRequestProtocol {
    func getCuriosityPhotos(page: Int) async throws -> PhotosResponse {
        return try await sendRequest(endpoint: .curiosity(page: page), responseModel: PhotosResponse.self)
    }
}
