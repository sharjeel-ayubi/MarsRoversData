//
//  NetworkMonitor.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 22/12/2023.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private var monitor: NWPathMonitor?

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor?.start(queue: DispatchQueue.global(qos: .background))
    }

    func stopMonitoring() {
        monitor?.cancel()
    }

    func isInternetConnected() -> Bool {
        let status = monitor?.currentPath.status
        return status == .satisfied
    }
}
