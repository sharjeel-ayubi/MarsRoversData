//
//  RepositoryProtocol.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 16/11/2023.
//

import Foundation

protocol PhotosRepositoryProtocol {
    associatedtype NetworkRequest

    var request: NetworkRequest { get set }
    init(request: NetworkRequest)
    
    func getPhotos(page: Int) async throws -> PhotosResponse
}
