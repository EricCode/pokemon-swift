//
//  pokeCell.swift
//  pokemon
//
//  Created by EricYang on 2017/5/30.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit

class pokeCell: UICollectionViewCell {
   
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: pokemon!
    func configureCell(pokemon: pokemon){
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
    }
    

    
    
}
