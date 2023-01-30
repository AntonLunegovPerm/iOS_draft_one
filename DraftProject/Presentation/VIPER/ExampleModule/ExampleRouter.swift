//
//  ExampleRouter.swift
//  DraftProject
//
//  Created by Антон Лунегов on 29.01.2023.
//

import UIKit

// MARK: - Protocols

protocol ExampleRouterProtocol: RouterProtocol {
    func dismissController()
}

final class ExampleRouter: ExampleRouterProtocol {
    
    func dismissController() {
        
    }
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
    
}
