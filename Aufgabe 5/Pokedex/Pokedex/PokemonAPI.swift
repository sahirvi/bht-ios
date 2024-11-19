//
//  ViewModel.swift
//  Pokedex
//
//  Created by sahi on 20.12.21.
//

import SwiftUI

class PokemonAPI: ObservableObject {
    
    @Published var pokemon = [PokemonModel] ()
    @Published var filteredPokemon = [PokemonModel]()
    let baseUrl = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init() {
        getPokemon()
    }
    
    func getPokemon() {
        guard let url = URL(string: baseUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data?.removeNullsFrom(string: "null,") else { return }
            guard let pokemon = try? JSONDecoder().decode([PokemonModel].self, from: data) else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }.resume()
    }
    
    func filterPokemon(by filter: String) {
        filteredPokemon = pokemon.filter({ $0.type == filter })
    }
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
