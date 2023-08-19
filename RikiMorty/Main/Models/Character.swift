//
//  Character.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation

struct CharactersData: Codable {
    let characters: [Character]?
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let imageURL: String?
    let episodes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin
        case imageURL = "image"
        case episodes = "episode"
    }
}
