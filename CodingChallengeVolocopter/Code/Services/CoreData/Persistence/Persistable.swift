//
//  Persistable.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 19/12/2023.
//

import Foundation

protocol Persistable: Identifiable {
    var id: Int { get set }
}
