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
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
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
        var characters: [CharacterModel] = []
        characters.append(CharacterModel(id: 1, name: "character 1", status: "statis 1", gender: "Male", imageUrl: nil, episodes: [], url: "url 1"))
        characters.append(CharacterModel(id: 2, name: "character 2", status: "statis 2", gender: "Male", imageUrl: nil, episodes: [], url: "url 2"))
        characters.append(CharacterModel(id: 3, name: "character 3", status: "statis 3", gender: "Male", imageUrl: nil, episodes: [], url: "url 3"))
        characters.append(CharacterModel(id: 4, name: "character 4", status: "statis 4", gender: "Male", imageUrl: nil, episodes: [], url: "url 3"))
        characters.append(CharacterModel(id: 5, name: "character 5", status: "statis 5", gender: "Male", imageUrl: nil, episodes: [], url: "url 3"))
        let viewModel = MainTableViewModel(characters: characters)
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
