//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Sukhrat on 02.02.17.
//  Copyright © 2017 Sukhrat. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        currentEvoImg.image = img
        idLbl.text = "\(pokemon.pokedexID)"
        
        pokemon.loadPokemonDetails {
            
            
            print("did arrive here")
            // whatever we write will only be called after the network call is complete!
            self.updateUI()
        }
    }
    
    func updateUI() {
        attackLbl.text = pokemon.attack
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        defenceLbl.text = pokemon.defence
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No evolutions"
            nextEvoImg.isHidden = true
        } else {
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
            let string = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLvl)"
            evoLbl.text = string
        }
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
   
}
