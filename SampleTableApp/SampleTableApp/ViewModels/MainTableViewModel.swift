//
//  MainTableViewModel.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

class MainTableViewModel {
    private let characters: [CharacterModel]
    
    init(characters: [CharacterModel]) {
        self.characters = characters.sorted(by: { (model1, model2) -> Bool in
            if let name1 = model1.name, let name2 = model2.name {
                return name1 < name2
            } else {
                return false
            }
        })
    }
    
    var getRowsCount: Int {
        return self.characters.count
    }
    
    func getCharacterFor(row: Int) -> CharacterModel {
        return characters[row]
    }
}
