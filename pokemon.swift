//
//  pokemon.swift
//  pokemon
//
//  Created by EricYang on 2017/5/30.
//  Copyright © 2017年 eric. All rights reserved.
//

import Foundation

class pokemon{
    
    private var _name:String!
    private var _pokedexID:Int!
    
    var name:String{
    
        return _name
    
    }
    
    var pokedexID:Int{
        
        return _pokedexID
        
    }
    
    init(name:String, pokedexID:Int){
        
        self._name = name
        self._pokedexID = pokedexID
    
    }
    
    
    
    
}
