//
//  Router.swift
//
//  Created by LAV on 23.06.2021.
//

import UIKit
import FINNBottomSheet

typealias RouterCompletions = [UIViewController : CompletionBlock]

final class Router: NSObject {
    
    // MARK:- Private variables
    fileprivate weak var rootController: UINavigationController?
    
    fileprivate var completions: RouterCompletions
    
    private lazy var transitioningDelegate = BottomSheetTransitioningDelegate(
        contentHeights: [.bottomSheetAutomatic],
        startTargetIndex: 0
    )
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    var toPresent: UIViewController? {
        return rootController
    }
}

// MARK:- Private methods
private extension Router {
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK:- Routable
extension Router: Routable {
    func presentModal(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        
        if let vc = module?.toPresent {
            vc.transitioningDelegate = transitioningDelegate
            vc.modalPresentationStyle = .custom
            rootController?.present(controller, animated: animated, completion: nil)
        }
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
            else { assertionFailure("⚠️Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }

        rootController?.pushViewController(controller, animated: true)
    }
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: CompletionBlock?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool, completion: CompletionBlock?) {
        rootController?.popToRootViewController(animated: animated, completion: {
            completion?()
        })
    }
    
    func setRootViewController(_ vc: UIViewController) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = vc
        }
    }
    
    func setRootNavController(_ navC: UINavigationController) {
        self.rootController = navC
    }
}
