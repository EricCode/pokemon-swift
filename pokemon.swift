//
//  pokemon.swift
//  pokemon
//
//  Created by EricYang on 2017/5/30.
//  Copyright © 2017年 eric. All rights reserved.
//

import Foundation
import Alamofire

class pokemon{
    
    private var _name:String!
    private var _pokedexID:Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    
    
    var nextEvolutionName:String{
        
        if _nextEvolutionName == nil{
            
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId:String{
        
        if _nextEvolutionId == nil{
            
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel:String{
        
        if _nextEvolutionLevel == nil{
            
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var description:String{
        
        if _description == nil{
            
            _description = ""
        }
        return _description
    }
    
    var type:String{
        
        if _type == nil{
            
            _type = ""
        }
        return _type
    }
    
    var defense:String{
        
        if _defense == nil{
            
            _defense = ""
        }
        return _defense
    }
    
    var height:String{
        
        if _height == nil{
            
            _height = ""
        }
        return _height
    }
    
    var weight:String{
        
        if _weight == nil{
            
            _weight = ""
        }
        return _weight
    }
    
    var attack:String{
        
        if _attack == nil{
            
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt:String{
        
        if _nextEvolutionTxt == nil{
            
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    
    
    var name:String{
    
        return _name
    
    }
    
    var pokedexID:Int{
        
        return _pokedexID
        
    }
    
    init(name:String, pokedexID:Int){
        
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
       
    }
    
    func downloadPokemonDetail(complete: @escaping DownloadComplete){
        
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            //print(response.result.value!)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"]as? Int{
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0{
                    
                    for i in (0..<types.count){
                        if i == 0{
                            if let typeName = types[i]["name"]{
                                self._type = "\(typeName.capitalized)"
                            }
                        }
                        else{
                            if let typeName = types[i]["name"]{
                                 self._type! += "/\(typeName.capitalized)"
                            }
                        }
                    }
                }else{
                    
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0{
                    
                    if let resource_uri = descArr[0]["resource_uri"]{
                        let url = "\(URL_BASE)\(resource_uri)"
                        
                         Alamofire.request(url).responseJSON(completionHandler: { (response) in
                            
                            if let discDict = response.result.value as? Dictionary<String, AnyObject>{
                                
                                if let description = discDict["description"] as? String{
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    
                                    
                                }
                            }
                            
                            complete()
                         })
                        
                    }else{
                        
                        self._description = ""
                        
                    }
                   
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolution.count > 0{
                    
                    if let nextEvo = evolution[0]["to"] as? String{
                        
                        //Because the evolution of pokemon show 'mega'
                        if nextEvo.range(of: "mega") == nil{
                            
                            self._nextEvolutionName = nextEvo
                            
                            
                            if let uri = evolution[0]["resource_uri"] as? String{
                                
                                //get nextEvolutionId
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                                
                                
                                if let lvlExist = evolution[0]["level"]{
                                    
                                    if let lvl = lvlExist as? Int{
                                        
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                    
                                    
                                }else{
                                    
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                }
                
                
            }
            complete()
       
        
        }
        
        
    }
    
    
    
    
}
