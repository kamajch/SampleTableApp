//
//  ApiManager.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 05/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation
import UIKit

final class ApiManager {
    private let baseUrl: URL?
    private let imageCache = NSCache<NSString, UIImage>()
    
    init(baseUrl: URL?) {
        self.baseUrl = baseUrl
    }
    init() {
        self.baseUrl = nil
    }
    
    func getCharactersFromApi(completion: @escaping (Result<CharacterData, Error>) -> Void) {
        guard let url = baseUrl else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                fatalError("Data and error are nil")
            }
            
            let result = Result(catching: {
                try JSONDecoder().decode(CharacterData.self, from: data)
            })
            completion(result)
        }
        .resume()
    }
    func getEpisodeFromApi(url: URL, completion: @escaping (Result<EpisodeModel, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                fatalError("Data and error are nil")
            }
            
            let result = Result(catching: {
                try JSONDecoder().decode(EpisodeModel.self, from: data)
            })
            completion(result)
        }
        .resume()
    }
}
