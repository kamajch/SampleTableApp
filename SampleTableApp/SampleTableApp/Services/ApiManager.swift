//
//  ApiManager.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 05/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation
import UIKit

//enum ApiManagerError: Error {
//    case RequestFailure
//    case InvalidResponse
//    case Unknown
//}

final class ApiManager {
//    typealias CharacterDataCompletion = ([CharacterModel]?, ApiManagerError?) -> ()
    private let baseUrl: URL?
    private let imageCache = NSCache<NSString, UIImage>()
    
    init(baseUrl: URL?) {
        self.baseUrl = baseUrl
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
    
    func downloadImage(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
            if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                completion(.success(cachedImage))
            } else {
                URLSession.shared.dataTask(with: url) { (data, _, error) in
                    guard let data = data else {
                      if let error = error {
                        completion(.failure(error))
                        return
                      }
                      fatalError("Data and error are nil")
                    }
                    
                    let image = UIImage(data: data)
                    let result = Result(catching: {
                        image
                    })
                    if let image = image {
                        self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    }
                    completion(result)
                }
                .resume()
            }
        }
//    private func getCharactersFromJSON(data: Data?, completion: CharacterDataCompletion) {
//        if let data = data {
//            do {
//                let characters = try JSONDecoder().decode([CharacterModel].self, from: data)
//                completion(characters, nil)
//            } catch {
//                print(error.localizedDescription)
//                completion(nil, .InvalidResponse)
//            }
//        }
//    }
}
