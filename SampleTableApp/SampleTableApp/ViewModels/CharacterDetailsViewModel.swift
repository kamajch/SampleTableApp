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
    private var episodes: [EpisodeModel] = []
    
    init(character: CharacterModel) {
        self.character = character
        episodes.append(EpisodeModel(id: 1, name: "pieski", airDate: "22.03.2020", episode: "E1ED2"))
        episodes.append(EpisodeModel(id: 2, name: "koty", airDate: "22.03.2020", episode: "E1ED3"))
        episodes.append(EpisodeModel(id: 3, name: "pieski bardzo długa nazwa", airDate: "22.03.2020", episode: "E2ED2"))
        episodes.append(EpisodeModel(id: 4, name: "konie", airDate: "22.03.2020", episode: "E1ED2"))
        episodes.append(EpisodeModel(id: 5, name: "krowy", airDate: "22.03.2020", episode: "E1ED2"))
    }
    
    var getCharacterName: String {
        return "Name: \(character.name ?? "b/d")"
    }
    var getStatus: String {
        return "Status: \(character.status ?? "b/d")"
    }
    var getGender: String {
        return "Gender: \(character.gender ?? "b/d")"
    }
    var getUrl: String {
        return character.url
    }
    var getTitleText: String {
        return "Episodes with character"
    }
    var getEpisodesCount: Int {
        return episodes.count
    }
    
    func getEpisode(for row: Int) -> EpisodeModel {
        return episodes[row]
    }
}
