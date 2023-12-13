//
//  NotificationManager.swift
//  CodingChallengeVolocopter
//
//  Created by Sharjeel Ayubi on 13/12/2023.
//

import Foundation
import NotificationCenter

struct LocalNotification {
    var id: String
    var title: String
    var body: String
    var userInfo: [AnyHashable : Any]?
}

class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    var isGranted = false
    var setTab: ((RoverVehicle) -> Void)?
    let defaultNotification = LocalNotification(id: UUID().uuidString,
                                                title: "RoverImage",
                                                body: "This is a rover Image",
                                                userInfo: ["tab":RoverVehicle.spirit.rawValue])
    
    private override init() {
        super.init()
        notificationCenter.delegate = self
    }
    @MainActor
    func requestAuthorization() async throws {
        try await notificationCenter.requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
    }
    
    func sendNotification(locationNotification: LocalNotification? = nil) async {
        var notification: LocalNotification!
        if locationNotification != nil {
            notification = locationNotification
        } else {
            notification = defaultNotification
        }
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        if let userInfo = notification.userInfo {
            content.userInfo = userInfo
        }
        
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        try? await notificationCenter.add(request)
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner]
    }
    
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if let value = response.notification.request.content.userInfo["tab"] as? String, let tab = RoverVehicle(rawValue: value) {
            setTab?(tab)
        }
    }
}
