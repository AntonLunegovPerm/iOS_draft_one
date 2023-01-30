//
//  OnboardingCoordinator.swift
//
//  Created by LAV on 23.06.2022.
//

import Foundation

class OnboardingCoordinator: BaseCoordinator {
    private let factory : OnboardingFactoryProtocol & AboutAppProtocol
    private let router  : Routable
    
    init(with factory: OnboardingFactoryProtocol & AboutAppProtocol, router: Routable) {
        self.factory = factory
        self.router = router
    }
    
}

// MARK:- Coordinatable
extension OnboardingCoordinator: Coordinatable {
    func start() {
        performOnboarding()
    }
    
    func performOnboarding() {
//        showOnboarding(.step1)
//        router.setRootModule(tabBar)
    }
    
//    func showOnboarding(_ step: OnboardingStep)  {
//        let onComplete = { [weak self] in
//            if step != .step3 {
//                self?.showOnboarding(OnboardingStep.init(rawValue: step.rawValue + 1) ?? .step1)
//            } else {
//                SessionManager.isSeenOnboarding = true
//                self?.finishFlow?()
//            }
//        }
//
//        let view = factory.makeOnboardingView(step: step, onPolitic: { [weak self] in
//            self?.showPolitic()
//        }, onComplete: onComplete)
//        router.push(view)
//    }
    
    func showPolitic() {
        if let view = factory.makePolitics().toPresent {
            router.present(view)
        }
    }
}
