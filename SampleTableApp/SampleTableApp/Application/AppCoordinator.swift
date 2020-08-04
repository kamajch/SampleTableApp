//
//  AppCoordinator.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 03/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}

private enum Constants {
    static let mainColor: UIColor = UIColor(red: 34 / 255, green: 39 / 255, blue: 47 / 255, alpha: 1)
    static let navigationBarTintColor: UIColor = UIColor.white
    static let sampeTableVCTitle: String = "Sample Table App"
}

class AppCoordinator: Coordinator {
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    var navigationController: UINavigationController = LightContentNavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        configureNavigationBar()
        showMain()
    }
    
    private func configureNavigationBar() {
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.navigationBar.barTintColor = Constants.mainColor
        self.navigationController.navigationBar.tintColor = Constants.navigationBarTintColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: Constants.navigationBarTintColor]
        self.navigationController.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func showMain() {
        self.navigationController.pushViewController(prepareMainTableVC(), animated: true)
    }
    
    private func prepareMainTableVC() -> MainTableViewController {
        let vc = MainTableViewController()
        vc.title = Constants.sampeTableVCTitle
        return vc
    }
}

class LightContentNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
