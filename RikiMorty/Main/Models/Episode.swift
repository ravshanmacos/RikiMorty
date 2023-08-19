//
//  Episode.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 19.08.2023.
//

import Foundation

struct Episode: Codable {
    let id: Int?
    let name: String?
    let airDate: String?
    let episode: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode
    }
}
