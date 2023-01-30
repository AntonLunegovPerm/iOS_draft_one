//
//  AnalyticProtocols.swift
//  NotificationService
//
//  Created by LAV on 09.10.2022.
//

import Foundation

/// --------------------------------- AnalyticsActionProtocol ----------------------------------------

protocol AnalyticsActionProtocol {
    var name: String { get }
}

extension AnalyticsActionProtocol where Self: RawRepresentable, Self.RawValue == String {
    var name: String {
        wordsName
    }
}

/// --------------------------------- AnalyticsProtocol ----------------------------------------

protocol AnalyticsProtocol {
    
    var analyticsComponent: AnalyticsComponentProtocol { get }
    
    func sendAnalytics(_ action: AnalyticsActionProtocol)
    func sendAnalytics(_ action: AnalyticsActionProtocol, withInfo: Bool?)
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, tags: [String: Any]?)
    func sendAnalytics(_ action: AnalyticsActionProtocol, tags: [String: Any]?, withInfo: Bool?)
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, message: String?)
    func sendAnalytics(_ action: AnalyticsActionProtocol, message: String?, withInfo: Bool?)
    
}

extension AnalyticsProtocol {
    
    func sendAnalytics(_ action: AnalyticsActionProtocol) {
        sendAnalytics(action, message: nil, withInfo: false)
    }
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, withInfo: Bool?) {
        sendAnalytics(action, message: nil, withInfo: withInfo)
    }
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, tags: [String: Any]? = nil) {
        sendAnalytics(action, message: "" /* tags?.jsonString() */, withInfo: false)
    }
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, tags: [String: Any]? = nil, withInfo: Bool? = false) {
        sendAnalytics(action, message: "" /* tags?.jsonString() */, withInfo: withInfo)
    }
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, message: String? = nil) {
        sendAnalytics(action, message: message, withInfo: false)
    }
    
    func sendAnalytics(_ action: AnalyticsActionProtocol, message: String? = nil, withInfo: Bool?) {
        Analytics.shared.log(action: action, component: analyticsComponent, tags: message, withUserInfo: withInfo ?? false)
    }
    
}

/// --------------------------------- AnalyticsComponentProtocol ----------------------------------------

protocol AnalyticsComponentProtocol {
    var name: String { get }
}

extension AnalyticsComponentProtocol where Self: RawRepresentable, Self.RawValue == String {
    var name: String {
        wordsName
    }
}


extension RawRepresentable where RawValue == String {
    // Separate case name to words or use rawValue
    var wordsName: String {
        let itemName = "\(self)"
        let rawValue = rawValue
        
        if itemName != rawValue {
            return (rawValue)
        } else {
            // TODO: 
            return  ""//(itemName.camelCaseToWords().capitalizingFirstLetter())
        }
    }
}
