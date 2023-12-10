//
//  OpportunityPhotoListViewModel.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 08/12/2023.
//

import Foundation
import Combine

class OpportunityPhotoListViewModel: BasePhotoListViewModel {
    
    @Published var page: Int = 0
    @Published var isLoading: Bool = false
    @Published var photos: [Photo] = []
    @Published var error: NetworkError?
    
    var repository: RepositoryProtocol
    var cancellable = Set<AnyCancellable>()
    
    init(repository: RepositoryProtocol = OpportunityRepository()) {
        self.repository = repository
    }
}
