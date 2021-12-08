//
//  Notification.swift
//  USport
//
//  Created by Alessandro Ferrara on 08/12/21.
//

import Foundation
import UserNotificationsUI

class Notification: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {(_,_) in
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.badge, .banner, .sound])
    }
    
    func createNotification() {
        let content = UNMutableNotificationContent()
        content.title = "ERROR"
        content.subtitle = "Some fields are incorrect"
        content.categoryIdentifier = "Actions"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: "In-App", content: content, trigger: trigger)
        
        //notification actions
        let close = UNNotificationAction(identifier: "Close", title: "Close", options: .destructive)
        let okay = UNNotificationAction(identifier: "Okay", title: "Okay", options: .destructive)
        let category = UNNotificationCategory(identifier: "Actions", actions: [close, okay], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
