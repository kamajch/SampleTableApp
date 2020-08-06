//
//  AppDelegate.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 03/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available (iOS 13.0, *) {
        } else {
            appCoordinator = AppCoordinator()
            appCoordinator.start()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = appCoordinator.rootViewController
            window?.makeKeyAndVisible()
        }
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
