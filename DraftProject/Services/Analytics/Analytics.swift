//
//  Analytics.swift
//  NotificationService
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit
import Swinject

// TODO: add for events tag
struct AnalyticsUserInfo {
    
    @Inject static private var settings: SettingsProtocol?
    
    private let userId: String
    private let userName: String
    private let deviceId: String
    private let osVersion: String
    private var analyticsPrefix: String {
        "\(userId) | \(userName) | \(deviceId) | \(osVersion) |"
    }
    private let addInfo: String?
    
    init(addInfo: String?) {
        self.userId = AnalyticsUserInfo.settings?.auth.userName ?? ""
        self.userName = AnalyticsUserInfo.settings?.auth.userName ?? ""
        self.deviceId = UIDevice.current.localizedModel
        self.osVersion = UIDevice.current.systemVersion
        self.addInfo = addInfo
    }
    
    var fullInfo: String {
        return analyticsPrefix + (addInfo ?? "")
    }
}

/// --------------------------------- Analytics ----------------------------------------

class Analytics {
    
    static let shared = Analytics()
    
    private var services:       [AnalyticProviderType] = []
    private var trackingEvents: [AnalyticsActionProtocol] = []
    
    private init() {
        trackingEvents.append(contentsOf: AnalyticsAction.BaseActions.allCases)
        trackingEvents.append(contentsOf: AnalyticsAction.Authorization.allCases)
    }
    
    /// for adding new Services and setup them
    func registerProvider(provider: AnalyticProviderType) {
        provider.setup()
        services.append(provider)
    }
    
    func log(action: AnalyticsActionProtocol,
             component: AnalyticsComponentProtocol,
             tags: String? = nil,
             withUserInfo: Bool = false,
             filename: String = #file,
             line: Int = #line,
             column: Int = #column,
             funcName: String = #function) {
        
        if shouldTrack(action: action) {
            services.forEach({ $0.log(action, component: component, tags: tags, withUserInfo: withUserInfo) })
        } else {
            print("🟡 WARNING: Action '\(action.name)' NOT in allowed actions list" )
        }
    }
    
    private func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    private func shouldTrack(action: AnalyticsActionProtocol) -> Bool {
        let actionsNames = trackingEvents.map ({ String(reflecting: $0) })
        return actionsNames.contains(String(reflecting: action))
    }
    
}
