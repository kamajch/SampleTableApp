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
    static let mainColor: UIColor = UIColor.gray
    static let navigationBarTintColor: UIColor = UIColor.white
    static let sampeTableVCTitle: String = "Sample Table App"
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController = LightContentNavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        configureNavigationBar()
        showMain()
    }
    
    func showCharacterDetails(for character: CharacterModel) {
        self.navigationController.pushViewController(prepareCharacterDetailsVC(character: character), animated: true)
    }
    func showMainTable(for characters: CharacterData?) {
        self.navigationController.pushViewController(prepareMainTableVC(for: characters), animated: true)
    }
    
    private func configureNavigationBar() {
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.navigationBar.barTintColor = Constants.mainColor
        self.navigationController.navigationBar.tintColor = Constants.navigationBarTintColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: Constants.navigationBarTintColor]
        self.navigationController.navigationBar.titleTextAttributes = textAttributes
    }
    private func showMain() {
        self.navigationController.pushViewController(prepareStartVC(), animated: true)
    }
    private func prepareStartVC() -> StartViewController {
        let viewModel = StartViewModel()
        let vc = StartViewController()
        vc.loadViewIfNeeded()
        vc.setViewModel(for: viewModel)
        vc.coordinator = self
        return vc
    }
    private func prepareMainTableVC(for characters: CharacterData?) -> MainTableViewController {
        let viewModel = MainTableViewModel(characters: characters?.results ?? [])
        let vc = MainTableViewController()
        vc.title = Constants.sampeTableVCTitle
        vc.setViewModel(for: viewModel)
        vc.coordinator = self
        return vc
    }
    private func prepareCharacterDetailsVC(character: CharacterModel) -> CharacterDetailsViewController {
        let vm = CharacterDetailsViewModel(character: character)
        let vc = CharacterDetailsViewController()
        vc.setViewModel(for: vm)
        vc.title = character.name
        return vc
    }
}

class LightContentNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
