//
//  AppDelegate.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 24/01/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard #available(iOS 13, *) else {
            window = UIWindow()
            let coordinator = ListCoordinator(navigationController: UINavigationController())
            coordinator.start()
            window?.rootViewController = coordinator.navigationController
            window?.makeKeyAndVisible()
            return true
        }
        return true
    }
    
    // MARK: Private
    
    private var appCoordinator: Coordinator?
}

