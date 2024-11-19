//
//  PokemonModel.swift
//  Pokedex
//
//  Created by sahi on 20.12.21.
//

import SwiftUI

struct PokemonModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let imageUrl: String
    let description: String
    let attack: Int
    let defense: Int
    let height: Int
    let weight: Int
    
    var backgroundColor: Color {
        switch type {
        case "bug", "poison": return Color("Background-Bug")
        case "dragon": return Color("Background-Dragon")
        case "electric": return Color("Background-Electric")
        case "fairy": return Color("Background-Fairy")
        case "fighting": return Color("Background-Fighting")
        case "fire": return Color("Background-Fire")
        case "flying": return Color("Background-Flying")
        case "grass": return Color("Background-Grass")
        case "ground": return Color("Background-Ground")
        case "ice": return Color("Background-Ice")
        case "normal": return Color("Background-Normal")
        case "psychic": return Color("Background-Psychic")
        case "rock": return Color("Background-Rock")
        case "steel": return Color("Background-Steel")
        case "water": return Color("Background-Water")
        default: return Color(.black)
        }
    }
    
    var typeColor: Color {
        switch type {
        case "bug", "poison": return Color("Type-Bug")
        case "dragon": return Color("Type-Dragon")
        case "electric": return Color("Type-Electric")
        case "fairy": return Color("Type-Fairy")
        case "fighting": return Color("Type-Fighting")
        case "fire": return Color("Type-Fire")
        case "flying": return Color("Type-Flying")
        case "grass": return Color("Type-Grass")
        case "ground": return Color("Type-Ground")
        case "ice": return Color("Type-Ice")
        case "normal": return Color("Type-Normal")
        case "psychic": return Color("Type-Psychic")
        case "rock": return Color("Type-Rock")
        case "steel": return Color("Type-Steel")
        case "water": return Color("Type-Water")
        default: return Color(.black)
        }
    }
}

let BULBASAUR = PokemonModel(id: 1,
                             name: "Bulbasaur",
                             type: "poison",
                             imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334",
                             description: "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun’s rays, the seed grows progressively larger.",
                             attack: 49,
                             defense: 49,
                             height: 7,
                             weight: 69
)

let CHARMANDER = PokemonModel(id: 4,
                              name: "Charmander",
                              type: "fire",
                              imageUrl: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2FD574A34D-6904-4EE2-8744-CC168094724F?alt=media&token=605a11a7-86f7-40cf-9593-fe92c51ab53d",
                              description: "The flame that burns at the tip of its tail is an indication\nof its emotions. The flame wavers when Charmander\nis enjoying itself. If the Pokémon becomes enraged,\nthe flame burns fiercely.",
                              attack: 52,
                              defense: 43,
                              height: 6,
                              weight: 85
)
