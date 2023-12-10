//
//  PhotoListViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 14/11/2023.
//

import Foundation
import Combine

class CuriosityPhotoListViewModel: BasePhotoListViewModel {
    
    @Published var page: Int = 0
    @Published var isLoading: Bool = false
    @Published var photos: [Photo] = []
    @Published var error: NetworkError?
    
    var repository: RepositoryProtocol
    var cancellable = Set<AnyCancellable>()
    
    init(repository: RepositoryProtocol = CuriosityRepository()) {
        self.repository = repository
    }
}
