//
//  MainTableViewModel.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

class MainTableViewModel {
    private var characters: [CharacterModel] = []
    private let apiManager = ApiManager(baseUrl: API.baseUrl)
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    var valueChanges: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    init(characters: [CharacterModel]) {
        self.characters = self.sortCharacters(characters: characters)
    }
    
    var getRowsCount: Int {
        return self.characters.count
    }
    
    func getCharacterFor(row: Int) -> CharacterModel {
        return characters[row]
    }
    
    func getCharactersFromApi() {
        if isLoading == false {
            isLoading = true
            apiManager.getCharactersFromApi { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let characters):
                    self?.characters = self?.sortCharacters(characters: characters.results) ?? []
                    self?.valueChanges?()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func sortCharacters(characters: [CharacterModel]) -> [CharacterModel] {
        let sortedCharacters = characters.sorted(by: { (model1, model2) -> Bool in
            if let name1 = model1.name, let name2 = model2.name {
                return name1 < name2
            } else {
                return false
            }
        })
        return sortedCharacters
    }
}
