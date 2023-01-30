//
//  KeychainWrapper.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import SwiftKeychainWrapper

extension KeychainWrapper {
    func setValue(_ value: Any?, forKey: String) {
        guard let value = value else { return }
        
        switch value {
        case is Int:
            set(value as! Int, forKey: forKey)
        case is String:
            set(value as! String, forKey: forKey)
        case is Bool:
            set(value as! Bool, forKey: forKey)
        case is Float:
            set(value as! Float, forKey: forKey)
        case is Double:
            set(value as! Double, forKey: forKey)
        case is Data:
            set(value as! Data, forKey: forKey)
        default:
            assertionFailure("Need add new type for saving in keychain")
        }
    }
    
    func getValue(_ key: String) -> Any? {
        if let stringVal = string(forKey: key) {
            return stringVal
        } else if let integerVal = integer(forKey: key) {
            return integerVal
        } else if let boolVal = bool(forKey: key) {
            return boolVal
        } else if let floatVal = float(forKey: key) {
            return floatVal
        } else if let doubleVal = double(forKey: key) {
            return doubleVal
        } else if let objectVal = object(forKey: key) {
            return objectVal
        } else if let dataVal = data(forKey: key) {
            return dataVal
        }
        
        return nil
    }
    
}
