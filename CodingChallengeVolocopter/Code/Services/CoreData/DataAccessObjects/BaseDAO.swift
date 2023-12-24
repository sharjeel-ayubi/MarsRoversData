//
//  BaseDAO.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 19/12/2023.
//

import Foundation
import Combine

protocol BaseDAO {

    associatedtype Entity
    associatedtype Storage

    var storage: Storage { get }
    init(storage: Storage)

    /// Updates an entity if it exists in the model, otherwise, the entity will be created
    func updateOrAdd(_ entity: Entity) -> AnyPublisher<Entity, AppError>
    func add(_ entity: Entity) -> AnyPublisher<Entity, AppError>
    func getAll(withRover rover:String?, andCamera camera: String?, page: Int?) -> AnyPublisher<[Entity], AppError>
    func delete(_ entity: Entity) -> AnyPublisher<Bool, AppError>
    func deleteAll(withRover rover:String?, andCamera camera: String?) -> AnyPublisher<Bool, AppError>
}
