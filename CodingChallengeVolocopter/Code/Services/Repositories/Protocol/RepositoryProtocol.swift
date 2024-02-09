//
//  RepositoryProtocol.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 16/11/2023.
//

import Foundation
import Combine

protocol RepositoryProtocol {
    func getPhotos(page: Int, filter: String) -> AnyPublisher<[Photo], AppError>
    func deletePhoto(photo: Photo)
}
