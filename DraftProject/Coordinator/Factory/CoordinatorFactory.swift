//
//  CoordinatorFactory.swift
//
//  Created by LAV on 23.06.2022.
//

import UIKit

final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}

// MARK:- CoordinatorFactoryProtocol
extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeOnboardingCoordinator(router: Routable) -> Coordinatable & Finishable {
        return OnboardingCoordinator(with: modulesFactory, router: router)
    }
    
//    func makeAuthorizationCoordinator(router: Routable) -> Coordinatable & Finishable {
////        return AuthorizationCoordinator(with: modulesFactory, router: router)
//    }
    
//    func makeMainCoordinator(router: Routable) -> Coordinatable & Finishable {
////        return MainTabBarCoordinator(with: modulesFactory, router: router)
//    }
}

// MARK:- Private methods
private extension CoordinatorFactory {
    func router(_ navController: UINavigationController?) -> Routable {
        return Router(rootController: navController ?? UINavigationController())
    }
}
