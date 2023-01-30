//
//  ReachabilityManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import Alamofire
import Combine

class ReachabilityManager: NSObject {

    static let shared = ReachabilityManager()
    let reachSubject = CurrentValueSubject<Bool, Error>(true)
    
    var isOnline: Bool {
        reachSubject.value
    }

    override init() {
        super.init()

        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { [weak self] (status) in
            switch status {
            case .notReachable:
                self?.reachSubject.value = false
            case .reachable:
                self?.reachSubject.value = true
            case .unknown:
                self?.reachSubject.value = false
            }
        })
    }

}
