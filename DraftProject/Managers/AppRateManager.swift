//
//  AppRateManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import StoreKit

class AppRateManager {

    static func rateApp() {
        // TODO: any condition before
        AppRateManager.storeRate()
    }
    
    private static func storeRate() {
        if true {
            // to Store
            requestReviewManually()
        } else {
            // in App
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    private static func requestReviewManually() {
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id" + storeAppId + "?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
}
