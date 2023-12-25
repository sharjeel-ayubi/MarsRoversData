//
//  AppErrorProtocol.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 26/12/2023.
//

import Foundation

protocol AppErrorProtocol: Identifiable {
    var title: String { get }
    var errorDescription: String { get }
}
