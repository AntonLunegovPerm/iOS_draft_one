//
//  AnalyticEvents.swift
//  NotificationService
//
//  Created by LAV on 09.10.2022.
//

import Foundation

enum AnalyticsAction: CaseIterable {

    enum BaseActions: String, CaseIterable, AnalyticsActionProtocol {
        case error
        case search
        case refresh
        case sorting
    }

    enum Authorization: String, CaseIterable, AnalyticsActionProtocol {
        case restorePassword
        case showPassword
        case hidePassword
    }
    
}
