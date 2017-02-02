//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sukhrat on 30.01.17.
//  Copyright © 2017 Sukhrat. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weigth: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    
    var name: String {
        
        return _name

    }
    
    var pokedexID: Int {
        
        return _pokedexID
        
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
    }
    
}
