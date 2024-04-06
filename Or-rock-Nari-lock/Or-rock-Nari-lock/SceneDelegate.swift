//
//  SceneDelegate.swift
//  Or-rock-Nari-lock
//
//  Created by 박동재 on 2/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = StockDetailViewController()
        window?.makeKeyAndVisible()
    }

}

