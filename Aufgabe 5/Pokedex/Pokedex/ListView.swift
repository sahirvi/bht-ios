//
//  ListElement.swift
//  Pokedex
//
//  Created by sahi on 20.12.21.
//

import SwiftUI
import Kingfisher

struct ListView: View {
    let pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack (alignment: .leading){
                    Text(String(format: "#%03d", pokemon.id))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                        .padding(.leading)
                        .foregroundColor(Color("idColor"))
                    
                    Text(pokemon.name.capitalized)
                        .font(.system(size: 30)).bold()
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    HStack {
                        Image("\(pokemon.type)")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        Text(pokemon.type.capitalized)
                            .font(.subheadline).bold()
                            .foregroundColor(.white)
                            .padding(.leading, -10)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 7)
                        
                    }.background(pokemon.typeColor)
                        .cornerRadius(10)
                        .shadow(color: pokemon.typeColor, radius: 2, x: 0.0, y: 0.0)
                        .padding(.top, -10)
                        .padding(.bottom, 20)
                        .padding(.leading)
                    
                }
                .frame(width: 200, height: 120, alignment: .leading)
                VStack {
                    KFImage(URL(string: pokemon.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 20)
                        .padding(.leading)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
                }
            }
        }
        .background(pokemon.backgroundColor)
        .cornerRadius(12)
        .shadow(color: pokemon.backgroundColor, radius: 6, x: 0.0, y: 0.0)
    }
}

struct ListElement_Previews: PreviewProvider {
    static var previews: some View {
        ListView(pokemon: BULBASAUR)
    }
}
