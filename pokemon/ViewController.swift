//
//  ViewController.swift
//  pokemon
//
//  Created by EricYang on 2017/5/30.
//  Copyright © 2017年 eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [pokemon]()
    var filterPokemons = [pokemon]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        
    }
    
    
    // get pokeID with pokemon's name
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do{
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            //print(rows)
            
            for row in rows{
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = pokemon(name: name, pokedexID: pokeID)
                
                pokemons.append(poke)
                
            }
          
        }catch let err as NSError{
            
            print(err.debugDescription)
        }
        
    }

 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? pokeCell{
        
            let poke: pokemon
            
            if inSearchMode{
                
                poke = filterPokemons[indexPath.row]
                cell.configureCell(pokemon: poke)
                
            }else{
                
                poke = pokemons[indexPath.row]
                cell.configureCell(pokemon: poke)

            }
            
            return cell
        
        }else{
            
            return UICollectionViewCell()
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: pokemon
        
        if inSearchMode{
            
            poke = filterPokemons[indexPath.row]
            
        }else{
            
            poke = pokemons[indexPath.row]
            
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            
            return filterPokemons.count
        
        }else{
        
            return pokemons.count
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""{
            
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        
        }else{
            
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filterPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonDetailVC"{
            if let detailVC = segue.destination as? PokemonDetailVC{
                if let poke = sender as? pokemon{
                    detailVC.pokemon = poke
                }
            }
        }
        
    }
    
    
}


