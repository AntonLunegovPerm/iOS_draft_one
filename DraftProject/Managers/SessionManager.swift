//
//  SessionManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import AuthenticationServices

struct SessionManager {
    
    @Inject static private var settings: SettingsProtocol?
    
    static func saveUserToken(_ token: String, from type: String) {
        settings?.auth.token = token
    }
    
    static func getUserToken() -> String? {
        settings?.auth.token
    }
    
    static var isAuthorized: Bool {
        settings?.auth.token.isEmpty ?? false
    }
    
    static func checkAppleSignStatus() {
        if let userID = UserDefaults.standard.string(forKey: "userID") {
                    
            // get the login status of Apple sign in for the app
            // asynchronous
            ASAuthorizationAppleIDProvider().getCredentialState(forUserID: userID, completion: {
                credentialState, error in

                switch(credentialState){
                case .authorized:
                    print("user remain logged in, proceed to another view")
                case .revoked:
                    print("user logged in before but revoked")
                case .notFound:
                    print("user haven't log in before")
                default:
                    print("unknown state")
                }
            })
        }
    }
    
}
