//
//  DataModel.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    var name: String?
    var status: String?
    var gender: String?
    var imageUrl: String?
    var episodes: [String]?
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case gender
        case imageUrl = "image"
        case episodes = "episode"
        case url
    }
}
