//
//  Coordinator.swift
//
//  Created by LAV on 23.06.2022.
//

import Foundation
import UIKit
import SwiftUI

protocol Coordinatable: AnyObject {
    func start()
}

protocol Finishable: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
 
protocol Presentable {
    var toPresent: UIViewController? { get }
}
 
extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}

extension UINavigationController: Presentable {
    func popToRootViewController(animated: Bool = true, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}

extension UIHostingController: BaseViewProtocol {

}

protocol Routable: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func presentModal(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func setRootViewController(_ vc: UIViewController)
    func setRootNavController(_ navC: UINavigationController)
    
    func popToRootModule(animated: Bool, completion: CompletionBlock?)
}
