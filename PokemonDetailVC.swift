//
//  PokemonDetailVC.swift
//  pokemon
//
//  Created by EricYang on 2017/6/3.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: pokemon!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        currentEvoImg.image = img
        pokedexLbl.text = "\(pokemon.pokedexID)"
        
        
        //get information of selected pokemon
        pokemon.downloadPokemonDetail {
            
            self.updateUI()
        }
   
    }
    
    
    func updateUI(){
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        weightLbl.text = pokemon.weight
        heightLbl.text = pokemon.height
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == ""{
         
            evoLbl.text = "No Evolutions"
            nextEvoImg.isHidden = true
            
        }else{
            
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            
            var str = ""
            if pokemon.nextEvolutionLevel == ""{
                
                str = "Next Evolution: \(pokemon.nextEvolutionName)"
            }
            else{
                
                str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            }
            
            evoLbl.text = str
        }
        
        
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
 

}
