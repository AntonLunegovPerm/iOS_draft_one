//
//  MainCoordinator.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator {
    fileprivate let factory: MainFactoryProtocol
    fileprivate let router : Routable
    fileprivate let navCotroller: UINavigationController
    
    init(with factory: MainFactoryProtocol,
         router: Routable,
         navCotroller: UINavigationController) {
        self.factory        = factory
        self.router         = router
        self.navCotroller   = navCotroller
    }
}

// MARK:- Coordinatable
extension MainCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK:- Private methods
private extension MainCoordinator {
    
    func performFlow() {
        let view = factory.makeMainPageView { [weak self] in
            self?.action1()
        } onAction2: { [weak self] in
            self?.action2()
        }

        if let presentView = view.toPresent {
            router.setRootNavController(navCotroller)
            router.push(presentView, animated: true, completion: {
                print("Completed")
            })
        }
    }
    
    private func action1() {
        
    }
    
    private func action2() {
        
    }
    
}
