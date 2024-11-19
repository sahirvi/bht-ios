//
//  ContentView.swift
//  Pokedex
//
//  Created by sahi on 20.12.21.
//

import SwiftUI

struct ContentView: View {
    private let gridItems = [GridItem(.flexible())]
    @ObservedObject var pokemonAPI = PokemonAPI()
    @State var searchText = ""
    @State var showFilterButtons = false
    @State var filterApplied = false
    @State var filterPressed = false
    @State var topAppear = false
    @State var scrollViewOffSet: CGFloat = 0
    @State var startOffSet: CGFloat = 0
    
    var searchedPokemon: [PokemonModel] {
        if searchText == "" { return pokemonAPI.pokemon }
        return pokemonAPI.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) ||  $0.type.lowercased().contains(searchText.lowercased()) ||  $0.description.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollViewReader {proxyReader in
                    ScrollView {
                        LazyVGrid(columns: gridItems, spacing: 20){
                            let pokemonData = filterApplied ? pokemonAPI.filteredPokemon : searchedPokemon
                            
                            ForEach(pokemonData) { pokemon in
                                NavigationLink(
                                    destination: DetailView(pokemon: pokemon),
                                    label: {
                                        ListView(pokemon: pokemon)
                                    })
                            }
                        }
                        .id("SCROLL_TO_TOP")
                        .overlay(
                            GeometryReader { proxy -> Color in
                                DispatchQueue.main.async {
                                    if startOffSet == 0 {
                                        self.startOffSet = proxy.frame(in: .global).minY
                                    }
                                    let offset = proxy.frame(in: .global).minY
                                    self.scrollViewOffSet = offset - startOffSet
                                }
                                return Color.clear
                            }
                        )
                    }
                    .navigationTitle("Pokedex")
                    .searchable(text: $searchText)
                    .overlay(
                        Button(action: {
                            withAnimation(.spring()) {
                                proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                            }
                        }, label: {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("button"))
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.5), radius: 30, x: 0, y: 0)
                        })
                            .padding()
                            .padding(.leading)
                            .opacity(-scrollViewOffSet > 450 ? 1 : 0)
                        ,alignment: .bottomLeading
                    )
                }
                
                VStack {
                    if showFilterButtons {
                        createButton(type: "poison", background: "Type-Bug")
                        createButton(type: "fire", background: "Type-Fire")
                        createButton(type: "water", background: "Type-Water")
                        createButton(type: "electric", background: "Type-Electric")
                        createButton(type: "flying", background: "Type-Flying")
                        createButton(type: "ground", background: "Type-Ground")
                    }
                    
                    let iconName = filterApplied ? "refresh" : "filter"
                    ButtonView(icon: iconName, height: 36, width: 36, show: $showFilterButtons) {
                        filterApplied ? filterApplied.toggle() : showFilterButtons.toggle()
                        filterPressed.toggle()
                    }.rotationEffect(.init(degrees: self.showFilterButtons ? 180 : 0))
                    
                }
                .padding()
                .animation(.spring(), value: filterPressed)
                //                .animation(.spring(), value: 100)
            }
        }
    }
    func createButton (type: String, background: String) -> ButtonView{
        ButtonView(icon: type, backgroundColor: Color(background), show: $showFilterButtons) {
            filterApplied.toggle()
            showFilterButtons.toggle()
            pokemonAPI.filterPokemon(by: type)
        }
    }
}

struct ButtonView: View {
    var icon: String
    var height: CGFloat = 24
    var width: CGFloat = 24
    var backgroundColor: Color = Color("button")
    @Binding var show: Bool
    
    var action: () -> Void
    
    var body: some View {
        Button(action: { action() }, label: {
            Image(icon)
                .resizable()
                .frame(width: width, height: height)
                .padding(16)
        })
            .background(backgroundColor)
            .foregroundColor(.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.5), radius: 30, x: 0.0, y: 0.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
