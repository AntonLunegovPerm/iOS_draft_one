//
//  AppDelegate.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import UIKit
import SwiftyBeaver
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate lazy var coordinator: Coordinatable = self.makeCoordinator()
    
    var rootController: UINavigationController {
        window?.rootViewController = UINavigationController()
        return window?.rootViewController as! UINavigationController
    }

    let container: Container = {
        registerDiContainer()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        coordinator.start()
        
        return true
    }
}

// MARK: DI
extension AppDelegate {
    static func registerDiContainer() -> Container {
        let container = Container()
        
        container.register(ReachabilityManager.self) { _ in ReachabilityManager() }
        container.register(UpdateManager.self) { _ in UpdateManager() }
        container.register(SettingsProtocol.self) { _ in Settings() }
        container.register(SettingsProtocol.self) { _ in Settings() }

        return container
    }
    
    func makeCoordinator() -> Coordinatable {
           return AppCoordinator(router: Router(rootController: rootController), factory: CoordinatorFactory())
    }
}


@propertyWrapper
struct Inject<Component> {
    
    var component: Component?
    
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.component = appDelegate.container.resolve(Component.self)
        }
    }
    
    public var wrappedValue: Component? {
        get { return component }
        mutating set { component = newValue }
    }
}
