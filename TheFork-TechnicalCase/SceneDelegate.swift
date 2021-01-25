//
//  SceneDelegate.swift
//  TheFork-TechnicalCase
//
//  Created by Luca Celiento on 24/01/21.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        appCoordinator = ListCoordinator(navigationController: UINavigationController())
        appCoordinator?.start()
        self.window?.rootViewController = appCoordinator?.navigationController
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Private
    
    private var appCoordinator: Coordinator?
}

