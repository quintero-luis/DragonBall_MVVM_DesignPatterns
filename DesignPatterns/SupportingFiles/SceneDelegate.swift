//
//  SceneDelegate.swift
//  DesignPatterns
//
//  Created by Alberto García-Muñoz on 17/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        let splashVC = SplashBuilder().build()
        let navController = UINavigationController(rootViewController: splashVC)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}
