//
//  ModuleProtocol.swift
//  DraftProject
//
//  Created by Антон Лунегов on 29.01.2023.
//

import UIKit

protocol RouterProtocol: AnyObject {
    var viewController: UIViewController? { get }
    
    func showTopAlertView(text: String, isSuccess: Bool, aboveNavBar: Bool)
    func presentUnauthorizedAlert()

}

// MARK: - Extensions

extension RouterProtocol {
    
    func showTopAlertView(text: String, isSuccess: Bool = false, aboveNavBar: Bool = false) {
        
    }
    
    func presentUnauthorizedAlert() {
       
    }
}
