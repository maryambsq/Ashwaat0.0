//
//  NotificationManager.swift
//  Ashwaat00.00
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 05/05/2025.
//

//  NotificationManager.swift

//YO!
// This file handles local notification logic permissions + sending alerts
// You just need to call this line from wherever you’re tracking location / movement:
//NotificationManager.shared.scheduleNotification(
//title: "Progress Paused!",
//body: "Your Tawaf progress has been paused since you left the Tawaf area.",
//secondsFromNow: 1
//)

// For when the user enters the location again:
//NotificationManager.shared.scheduleNotification(
    //title: "You’re Back!",
   // body: "You’ve re-entered the Tawaf area. Ready to resume?",
   // secondsFromNow: 1
//)
//Make sure to trigger these based on the main location/movement function
//like:
//onExitRegion() → show paused noti
//onEnterRegion() → show resume noti
//maybe also check speed if y’all are detecting walking



import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("❌ Notification permission error: \(error)")
                } else {
                    print("✅ Notification permission granted: \(granted)")
                }
            }
    }

    func scheduleNotification(title: String, body: String, secondsFromNow: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsFromNow, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Notification error: \(error)")
            }
        }
    }
}
