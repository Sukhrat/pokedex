//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sukhrat on 30.01.17.
//  Copyright © 2017 Sukhrat. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _nextEvoName: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _pokemonURL: String!
    

    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var defence: String {
        if _defence == nil {
            _defence = ""
        }
        
        return _defence
    }
    
    var height: String {
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var attack: String {
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
        
    }
    
    var  nextEvoTxt: String {
        
        if _nextEvoTxt == nil  {
            _nextEvoTxt =  ""
        }
        
        return _nextEvoTxt
        
    }
    
    var  nextEvoName: String {
        
        if _nextEvoName == nil  {
            _nextEvoName =  ""
        }
        
        return _nextEvoName
        
    }
    
    
    var  nextEvoId: String {
        
        if _nextEvoId == nil  {
            _nextEvoId =  ""
        }
        
        return _nextEvoId
        
    }
    
    var  nextEvoLvl: String {
        
        if _nextEvoLvl == nil  {
            _nextEvoLvl =  ""
        }
        
        return _nextEvoLvl
        
    }
    
    var name: String {
        
        return _name

    }
    
    var pokedexID: Int {
        
        return _pokedexID
        
    }
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
        
        self._pokemonURL = "\(URL_base)\(URL_pokemon)\(self.pokedexID)/"
    }
    
    func loadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defence = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defence)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalized
                        
                    }
                    
                    if types.count > 1 {
                        
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                        
                    }
                    
                    print(self._type)
                    
                } else {
                    
                    self._type = ""
                    
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let descUrl = "\(URL_base)\(url)"
                        Alamofire.request(descUrl).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(description)
                                }
                            }
                            completed()
                        })
                        
                    } else {
                        self._description = ""
                    }
                    
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                        
                        if let nextEvo = evolutions[0]["to"] as? String {
                            
                            if nextEvo.range(of: "mega") == nil {
                                
                                self._nextEvoName = nextEvo
                                
                                
                                if  let uri = evolutions[0]["resource_uri"] as? String {
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                    self._nextEvoId = nextEvoId
                                    
                                    if let lvlExist = evolutions[0]["level"] {
                                        if let lvl = lvlExist as? Int {
                                            self._nextEvoLvl = "\(lvl)"
                                        }
                                    } else {
                                        self._nextEvoLvl = ""
                                    }
                                }
                                
                            }
                            
                        }
                        print(self.nextEvoLvl)
                        print(self.nextEvoName)
                        print(self.nextEvoId)
                        
                    }
                    
                }
            }
            
            completed()
            
        }
        
    }
    
}
