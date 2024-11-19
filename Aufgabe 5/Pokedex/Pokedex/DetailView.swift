//
//  DetailView.swift
//  Pokedex
//
//  Created by sahi on 20.12.21.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    let pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        ZStack {
            pokemon.backgroundColor
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    VStack {
                        KFImage(URL(string: pokemon.imageUrl))
                            .resizable()
                            .frame(width: 150, height: 150)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
                    }
                    
                    VStack (alignment: .leading){
                        
                        Text(String(format: "#%03d", pokemon.id))
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .foregroundColor(Color("idColor"))
                        
                        
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                CardView(pokemon: pokemon)
            }
        }
    }
}

struct CardView: View {
    let pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack {
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
                    .padding(.vertical, 10)
                
            }.background(pokemon.typeColor)
                .cornerRadius(10)
                .padding(.top, 15)
                .shadow(color: pokemon.typeColor, radius: 2, x: 0.0, y: 0.0)
            
            Text(pokemon.description)
                .foregroundColor(Color("textColor"))
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            
            Text("Statistics")
                .padding(.vertical)
                .font(.system(size: 16, weight: .semibold))
            
            StatsChartView(pokemon: pokemon)
                .padding(.trailing)
            
        }
        .padding()
        .padding(.bottom, 400)
        .background(Color(.systemBackground))
        .cornerRadius(30)
        .padding(.top, 30)
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0.0, y: 0.0)
    }
}

struct StatsView: View {
    var statValue: Int = 100
    var statName: String = "HP"
    var statColor: Color = .blue
    var scaledUp = true
    
    var body: some View {
        
        HStack {
            Text(statName)
                .fontWeight(.semibold)
                .padding(.leading, 35)
                .padding(.vertical, 5)
                .frame(width: 110)
            
            
            HStack {
                Text("\(statValue)")
                    .frame(width: 42)
                    .padding(.trailing)
                    .foregroundColor(Color("textColor"))
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(width: 150, height: 10).animation(.default, value: scaledUp)
                        .foregroundColor(Color(.systemGray5))
                    
                    Capsule()
                        .frame(width: statValue <= 100 ? 150 * (CGFloat(statValue) / 100) : 150 , height: 10)
                        .animation(.default, value: scaledUp)
                        .foregroundColor(statColor)
                }
                Spacer()
            }.padding(.leading)
        }
    }
}

struct StatsChartView: View {
    let pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack {
            StatsView(statValue: pokemon.attack, statName: "Attack", statColor: pokemon.typeColor)
            StatsView(statValue: pokemon.defense, statName: "Defense", statColor: pokemon.typeColor)
            StatsView(statValue: pokemon.height, statName: "Height", statColor: pokemon.typeColor)
            StatsView(statValue: pokemon.weight, statName: "Weight", statColor: pokemon.typeColor)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
        StatsChartView(pokemon: BULBASAUR)
        DetailView(pokemon: BULBASAUR)
    }
}
