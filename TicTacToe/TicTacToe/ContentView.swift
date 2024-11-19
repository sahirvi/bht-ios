//
//  TTTBrain.swift
//  TicTacToe
//
//  Created by sahi on 10.11.21.
//
//  Tutorial: https://www.youtube.com/watch?v=MCLiPW2ns2w

import SwiftUI


struct ContentView: View {
    
    
    @StateObject private var tttBrain = TTTBrain()
    
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    LazyVGrid(columns: tttBrain.columns, spacing: 15){
                        ForEach(0..<9){i in
                            ZStack{
                                GameSquareView(proxy: geometry)
                                PlayerIndicator(systemImageName: tttBrain.moves[i]?.indicator ?? "")
                            }
                            .onTapGesture {
                                tttBrain.processPlayerMove(for: i)
                            }
                        }
                    }
                    Spacer()
                }
            }
            .disabled(tttBrain.isGameboardDisabled)
            .alert(item: $tttBrain.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {tttBrain.resetGame() }))
            })
        }
    }
    
}

enum Player{
    case human, computer
}


struct Move{
    let player: Player
    let boardIndex: Int
    
    var indicator: String{
        return player == .human ? "xmark" : "circle"
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameSquareView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(.darkGray)).cornerRadius(20)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
    
}

struct PlayerIndicator: View {
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
    }
    
}
