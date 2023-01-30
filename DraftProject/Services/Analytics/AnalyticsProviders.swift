//
//  AnalyticsProviders.swift
//  NotificationService
//
//  Created by LAV on 09.10.2022.
//

import Foundation

/// --------------------------------- AnalyticProviders ----------------------------------------

protocol AnalyticProviderType {
    
    func log(_ action: AnalyticsActionProtocol, component: AnalyticsComponentProtocol, tags: String?, withUserInfo: Bool)
    func setup()
    
}

final class GoogleAnalyticProvider: AnalyticProviderType {
    
    func log(_ action: AnalyticsActionProtocol, component: AnalyticsComponentProtocol, tags: String?, withUserInfo: Bool = false) {
        let label = withUserInfo ? AnalyticsUserInfo(addInfo: tags).fullInfo : tags
 
//        guard
//            let tracker = GAI.sharedInstance().defaultTracker,
//            let builder = GAIDictionaryBuilder.createEvent(withCategory: component.name, action: action.name, label: label, value: 0)
//            else { return }
//
//        tracker.set(kGAIScreenName, value: component.name)
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func setup() {
        var trackingIdKey = "TRACKING_ID"
        #if ALPHA
        trackingIdKey.append("-a")
        #elseif BETA
        trackingIdKey.append("-b")
        #endif
        
//        if let gai = GAI.sharedInstance(),
//           let gaConfigValues = Bundle.main.infoDictionary?["GoogleAnalytics"] as? [String: String],
//           let trackingId = gaConfigValues[trackingIdKey]
//        {
//            gai.logger.logLevel = .none
//            gai.trackUncaughtExceptions = false
//            gai.tracker(withTrackingId: trackingId)
//        } else {
//            assertionFailure("Google Analytics not configured correctly")
//        }
    }
    
}
