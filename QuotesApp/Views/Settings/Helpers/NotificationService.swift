//
//  NotificationService.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 2/13/22.
//

import UserNotifications
import SwiftUI
import QuotesAppService

class NotificationService: NSObject {
    
    let viewModel = ContentViewModel()
    private let notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        createPizzaSelectionCategory()
    }
    
    private func createPizzaSelectionCategory() {
        let action = UNNotificationAction(identifier: "daily_quote", title: "New Daily Quote", options: .foreground)
        let category = UNNotificationCategory(identifier: "daily_category", actions: [action], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
}

// MARK: - Select Time and Content
extension NotificationService {
    
    // creates the array of time for each notification
    func createArrayOfTimes(from: Date, to: Date, count: Int) -> [Date] {
        var arrayOfTimes: [Date] = []
        
        // split the interval by chunks
        let timeInterval = to.minutes(from: from) // in minutes
        let lengthOfChunk = timeInterval / count // also in minutes
        print(timeInterval, lengthOfChunk)
        
        var currentTime = from // for cycle to iterate and add more minutes
        for _ in 0..<count {
            currentTime = currentTime.withAddedMinutes(minutes: Double(lengthOfChunk))
            arrayOfTimes.append(currentTime)
        }
        
        return arrayOfTimes
    }
    
    // schedule all notifications
    func scheduleAllNotifications(from: Date, to: Date, count: Int) {
        let arrayOfTimes: [Date] = createArrayOfTimes(from: from, to: to, count: count)
        print(arrayOfTimes)
        for time in arrayOfTimes {
            let randomQuote = viewModel.getRandomQuote()
            let hour = Calendar.current.component(.hour, from: time)
            let minute = Calendar.current.component(.minute, from: time)
            addNotification(title: "New Daily Quote", body: randomQuote, hour: hour, minute: minute, categoryIdentifier: "daily_category")
        }
    }
}

//MARK: - PERIODIC NOTIFICATION
extension NotificationService {
    
    // up to 64 notifications!
    func addNotification(
        title: String,
        body: String,
        hour: Int,
        minute: Int = 0,
        seconds: Int = 0,
        notificationIdentifier: String? = nil,
        categoryIdentifier: String? = nil
    ) {
        
        // 1. Create MutableContent
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        /// set custom sound if you want
//        if let customSoundFileName = customSoundFileName {
//            content.sound = UNNotificationSound.init(named:UNNotificationSoundName(rawValue: customSoundFileName))
//        }
        
        /// set category if you want
        if let categoryIdentifier: String = categoryIdentifier {
            content.categoryIdentifier = categoryIdentifier
        }
        
        // 2. Create date component
        var dateComponents: DateComponents = DateComponents()
        //dateComponents.calendar = Calendar.current
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = seconds
        
        // 3. Create Trigger
        let trigger: UNCalendarNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // 4. Create Request
        let request: UNNotificationRequest = UNNotificationRequest(identifier: notificationIdentifier ?? UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error: Error = error {
                print("error: ", error.localizedDescription)
                return
            }
            print("added notification: \(request.identifier)")
            print("Notification at \(hour):\(minute)")
        }
    }
}

//MARK: - NOTIFICATION STATUS CHECK
extension NotificationService {
    
    //notification status
    func getPendingNotificationRequests() -> [UNNotificationRequest]? {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        var notificationRequests: [UNNotificationRequest] = [UNNotificationRequest]()
        notificationCenter.getPendingNotificationRequests { (requests) in
            notificationRequests = requests
            semaphore.signal()
        }
        semaphore.wait()
        return notificationRequests
    }
    
    func getPendingNotificationRequests(completion: @escaping([UNNotificationRequest]) -> Void) {
        notificationCenter.getPendingNotificationRequests { (requests) in
            completion(requests)
        }
    }
    
    func getDeliveredNotificationRequests() -> [UNNotification]? {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        var notificationRequests: [UNNotification] = [UNNotification]()
        notificationCenter.getDeliveredNotifications { (requests) in
            notificationRequests = requests
            semaphore.signal()
        }
        semaphore.wait()
        return notificationRequests
    }
    
    func getDeliveredNotificationRequests(completion: @escaping([UNNotification]) -> Void) {
        notificationCenter.getDeliveredNotifications { (requests) in
            completion(requests)
        }
    }
    
}

//MARK: - CLEAR NOTIFICATION
extension NotificationService {
    
    func removePendingNotificationRequests(identifiers: [String]) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    // VERY CRUCIAL!!!!
    func removePendingNotificationRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func clearDeliveredNotificationRequests(identifiers: [String]) {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
    
    func clearDeliveredNotificationRequests() {
        notificationCenter.removeAllDeliveredNotifications()
    }
}
