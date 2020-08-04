//
//  EpisodeMode.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

struct EpisodeModel: Codable {
    let id: Int
    var name: String
    var airDate: String
    var episode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
    }
}
