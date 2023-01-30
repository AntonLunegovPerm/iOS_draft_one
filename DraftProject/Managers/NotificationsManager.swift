//
//  NotificationsManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UserNotifications
import UIKit

class NotificationsManager: NSObject {
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        guard let aps = userInfo["aps"] as? [String: Any] else { return }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }
    
    var applicationStateString: String {
        if UIApplication.shared.applicationState == .active {
            return "active"
        } else if UIApplication.shared.applicationState == .background {
            return "background"
        } else {
            return "inactive"
        }
    }
    
    func requestNotificationAuthorization(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {succeed,error in
                
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
                
            })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
    }
}

@available(iOS 10, *)
extension NotificationsManager : UNUserNotificationCenterDelegate {
    
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        if let aps = userInfo["aps"] as? [String: Any] {

        } else {

        }
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }
    
    //swiftlint:disable cyclomatic_complexity
    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        
        guard let aps = userInfo["aps"] as? [String: Any] else { return }
        
        //TODO: Handle background notification
        completionHandler()
    }
}
