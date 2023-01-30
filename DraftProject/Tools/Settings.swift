//
//  Settings.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyUserDefaults
import UIKit
import SwiftyBeaver

protocol SettingsProtocol: AnyObject {
    var auth: Settings.Auth  { get set }
    var app: Settings.App  { get set }

    func cleanOnLogout()
}

private enum SettingsStorage {
    case keychain
    case userDefaults
}

class Settings: SettingsProtocol {

    static let shared: SettingsProtocol = Settings()
    
    // MARK: Params
    
    var auth = Auth()
    var app = App()
    

    private static let userDefaults = UserDefaults.standard
    fileprivate static let keychain = KeychainWrapper.standard
    
    private static var keychainCache = [String: Any?]()
    
    // MARK: Keys
    
    enum AppSettingsKey: String {
        // auth
        case username
        case password
        case token
        
        // app
        case isSeenOnboarding
    }
    
    private static let elements: [AppSettingsKey: SettingsStorage] = [
        // auth
        .username           : .keychain,
        .password           : .keychain,
        .token              : .keychain,
        
        // app
        .isSeenOnboarding   : .userDefaults
    ]
    
    // MARK: Logic
    
    private static subscript(_ key: AppSettingsKey) -> Any? {
        get {
            guard let storageType = elements[key] else {
                assertionFailure("No such key")
                return "Error"
            }
            
            switch storageType {
            case .keychain:
                return getKeychainValue(key: key.rawValue)
            case .userDefaults:
                return getUserDefaultsValue(key: key.rawValue)
            }
        }
        set {
            guard let storageType = elements[key] else {
                assertionFailure("No such key")
                return
            }
            
            switch storageType {
            case .keychain:
                setKeychainValue(value: newValue, key: key.rawValue)
            case .userDefaults:
                setUserDefaultsValue(value: newValue, key: key.rawValue)
            }
        }
    }
    
    // MARK: Access from storages -> to Providers?
    
    private static func getKeychainValue(key: String) -> Any? {
        if let value = keychainCache[key] {
            return value
        } else {
            if let value = keychain.getValue(key) {
                keychainCache[key] = value
                return value
            }
        }
        return nil
    }
    
    private static func getUserDefaultsValue(key: String) -> Any? {
        userDefaults.value(forKey: key)
    }
    
    // MARK: Set

    private static func setKeychainValue(value: Any?, key: String) {
        keychainCache[key] = value
        keychain.setValue(value, forKey: key)
    }
    
    private static func setUserDefaultsValue(value: Any?, key: String) {
        userDefaults.setValue(value, forKey: key)
    }
}

extension Settings {

    struct Auth {
        var userName: String {
            get { Settings.stringValue(.username) ?? "" }
            set { Settings[.username] = newValue }
        }
        var password: String {
            get { Settings.stringValue(.password)  ?? "" }
            set { Settings[.password] = newValue }
        }
        var token: String {
            get { Settings.stringValue(.token)  ?? "" }
            set { Settings[.token] = newValue }
        }
    }
    
    struct App {
        var isSeenOnboarding: Bool {
            get { Settings.boolValue(.isSeenOnboarding) ?? true }
            set { Settings[.isSeenOnboarding] = newValue }
        }
    }
    
    // MARK: SettingsProtocol
    
    func cleanOnLogout() {
        Settings.shared.auth.userName   = ""
        Settings.shared.auth.password   = ""
        Settings.shared.auth.token      = ""
    }
}


extension Settings {
    
    // MARK: Typed funcs
    
    private static func boolValue(_ key: AppSettingsKey) -> Bool? {
        if let value = Settings[key] as? Bool {
            return value
        }
        
        return nil
    }

    private static func stringValue(_ key: AppSettingsKey) -> String? {
        if let value = Settings[key] as? String {
            return value
        }
        return nil
    }

    private static func intValue(_ key: AppSettingsKey) -> Int? {
        if let value = Settings[key] as? Int {
            return value
        }
        return nil
    }
    
    private static func typedValue<T>(_ key: AppSettingsKey) -> T? {
        if let value = Settings[key] as? T {
            return value
        }
        return nil
    }
    
    // MARK: Codable
    
    private static func encodeData<T: Encodable>(data: T) -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let encodedData = try? encoder.encode(data) {
            return encodedData
        }
        return nil
    }
    
    private static func decodeData<T: Decodable>(data: Any?) -> T? {
        do {
            if let data = data as? Data {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            }
        } catch let error {
            SwiftyBeaver.error(error.localizedDescription)
            assertionFailure("Try to decode not decodable object - check type and data")
        }

        return nil
    }
}
