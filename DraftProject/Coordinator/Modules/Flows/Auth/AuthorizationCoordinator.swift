//
//  AuthorizationCoordinator.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit

typealias AuthCoordFactory = AuthorizationFactoryProtocol & AboutAppProtocol

final class AuthorizationCoordinator: BaseCoordinator {
    fileprivate let factory: AuthCoordFactory
    fileprivate let navigationController : UINavigationController
    
    init(with factory: AuthCoordFactory, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController  = navigationController
    }
}

// MARK:- Coordinatable
extension AuthorizationCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK:- Private methods
private extension AuthorizationCoordinator {
    
    func performFlow() {
        if let view = factory.makeEnterView(onComplete: finishFlow, onPolitic: { [weak self] in
            self?.showPolitics()
        }, onTermsUse: { [weak self] in
            self?.showUserAgreement()
        }).toPresent {
            navigationController.present(view, animated: true)
        }
    }
    
    func showPolitics() {
        if let view = factory.makePolitics().toPresent {
            navigationController.present(view, animated: true)
        }
    }
    
    func showUserAgreement() {
        if let view = factory.makeUserAgreement().toPresent {
            navigationController.present(view, animated: true)
        }
    }
    
}

