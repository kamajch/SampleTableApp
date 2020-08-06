//
//  SceneDelegate.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 03/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        appWindow.rootViewController = appCoordinator.rootViewController
        appWindow.makeKeyAndVisible()
        window = appWindow
    }
}
