//
//  CharacterDetailsViewModel.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

class CharacterDetailsViewModel {
    private let character: CharacterModel
    
    init(character: CharacterModel) {
        self.character = character
    }
    
    var getCharacterName: String {
        return ""
    }
    var getStatus: String {
        return character.status ?? "b/d"
    }
    var getGender: String {
        return character.gender ?? "b/d"
    }
}
