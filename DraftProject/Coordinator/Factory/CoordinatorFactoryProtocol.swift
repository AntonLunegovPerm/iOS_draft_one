//
//  CoordinatorFactoryProtocol.swift
//
//  Created by LAV on 23.06.2022.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    func makeOnboardingCoordinator(router: Routable)    -> Coordinatable & Finishable
//    func makeAuthorizationCoordinator(router: Routable) -> Coordinatable & Finishable
//    func makeMainCoordinator(router: Routable)          -> Coordinatable & Finishable
}
