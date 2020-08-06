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
    private let apiManager = ApiManager()
    private let dispatchGroup = DispatchGroup()
    
    var valueChanged: (() -> Void)?
    
    init(character: CharacterModel) {
        self.character = character
//        episodes.append(EpisodeModel(id: 1, name: "pieski", airDate: "22.03.2020", episode: "E1ED2"))
//        episodes.append(EpisodeModel(id: 2, name: "koty", airDate: "22.03.2020", episode: "E1ED3"))
//        episodes.append(EpisodeModel(id: 3, name: "pieski bardzo długa nazwa", airDate: "22.03.2020", episode: "E2ED2"))
//        episodes.append(EpisodeModel(id: 4, name: "konie", airDate: "22.03.2020", episode: "E1ED2"))
//        episodes.append(EpisodeModel(id: 5, name: "krowy", airDate: "22.03.2020", episode: "E1ED2"))
    }
    
    var characterName: String {
        return "Name: \(character.name ?? "b/d")"
    }
    var characterStatus: String {
        return "Status: \(character.status ?? "b/d")"
    }
    var characterGender: String {
        return "Gender: \(character.gender ?? "b/d")"
    }
    var characterUrl: String {
        return character.url
    }
    var titleText: String {
        return "Episodes with character"
    }
    var episodesCount: Int {
        return episodes.count
    }
    
    func getEpisode(for row: Int) -> EpisodeModel {
        return episodes[row]
    }
    func downloadEpisodes() {
        character.episodes?.forEach({ (episode) in
            if let url = URL(string: episode) {
                dispatchGroup.enter()
                apiManager.getEpisodeFromApi(url: url) { [weak self] result in
                    switch result {
                    case .success(let episode):
                        self?.episodes.append(episode)
                        self?.dispatchGroup.leave()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        })
        
        dispatchGroup.notify(queue: .main) {
            self.valueChanged?()
        }
    }
}
