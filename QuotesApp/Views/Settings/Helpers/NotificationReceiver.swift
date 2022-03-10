//
//  NotificationReceiver.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 2/13/22.
//

import SwiftUI
import UserNotifications

// Handle Incoming Requests
class NotificationReceiver: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        requestAuthorization(remote: true)
        notificationCenter.delegate = self
    }
    
    private func requestAuthorization(remote: Bool) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted: Bool, error: Error?) in
            if let error: Error = error {
                print("error: ", error.localizedDescription)
                return
            }
            if granted {
                self.notificationCenter.delegate = self
                print("granted: ", granted)
                if remote {
                    print("Registered for remote message")
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }
}
