//
//  AppCoordinator.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import UIKit

fileprivate enum LaunchInstructor {
    
    @Inject static private var settings: SettingsProtocol?
    
    case onboarding, authorization, main
        
    static func setup() -> LaunchInstructor {
        switch (settings?.app.isSeenOnboarding ?? false, SessionManager.isAuthorized) {
        case (false, false), (false, true):
            return .onboarding
        case (true, false):
            return .authorization
        case (true, true):
            return .main
        }
    }
}


protocol IAppCoordinator: AnyObject {
    func auth()
    func main()
    func onboarding()
}

final class AppCoordinator: BaseCoordinator {
    
    fileprivate let factory: CoordinatorFactoryProtocol
    fileprivate let router : Routable
    
    fileprivate var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    init(router: Routable, factory: CoordinatorFactory) {
        self.router  = router
        self.factory = factory
    }
}

// MARK:- Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        switch instructor {
        case .authorization: break
//            performAuthorizationFlow()
        case .onboarding: break
            performOnboarding()
        case .main: break
//            performMainFlow()
        }
    }
}

// MARK:- Private methods
private extension AppCoordinator {
    func performAuthorizationFlow() {
//        let coordinator = factory.makeAuthorizationCoordinator(router: router)
//        coordinator.finishFlow = { [unowned self, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
    
    func performOnboarding() {
        let coordinator = factory.makeOnboardingCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard
                let `self` = self,
                let `coordinator` = coordinator
                else { return }
            self.start()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performMainFlow() {

//        let coordinator = factory.makeMainCoordinator(router: router)
//        coordinator.finishFlow = { [weak self, weak coordinator] in
//            guard
//                let `self` = self,
//                let `coordinator` = coordinator
//                else { return }
//            
//            KeychainWrapper.shared.clear()
//            intercomeManager.logout()
//            firebaseHelper.logOut()
//            dailyBonusManager.reset()
//            
//            self.removeDependency(coordinator)
//            self.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
}
