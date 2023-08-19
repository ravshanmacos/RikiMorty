//
//  Routes.swift
//  RikiMorty
//
//  Created by Ravshanbek Tursunbaev on 18.08.2023.
//

import Foundation


struct Routes {
    private let baseRoute = "https://rickandmortyapi.com/api"
    
    var charactersRoute: String {
        return baseRoute + "/character"
    }
}
