//
//  TTTBrain.swift
//  TicTacToe
//
//  Created by sahi on 10.11.21.
//

import SwiftUI

final class TTTBrain: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int) {
        
        // Human Move Processing
        if isSquareOccupied(in: moves, forIndex: position) {return}
        moves[position] = Move(player: .human, boardIndex: position)
        
        if checkWinCondition (for: .human, in: moves){
            alertItem = AlertContext.humanWin
            return
        }
        if checkForDraw(in: moves){
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        
        // Computer Move Processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            let computerPosition = determineComputerPosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves){
                alertItem = AlertContext.computerWin
                return
            }
            if checkForDraw(in: moves){
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index :Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex==index})
    }
    
    func determineComputerPosition(in moves: [Move?]) -> Int{
        let winPattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        // Wenn es möglich ist, soll er im aktuellen Zug gewinnen
        let computerMoves = moves.compactMap{ $0 }.filter{ $0.player == .computer }
        let computerPositions = Set(computerMoves.map {$0.boardIndex})
        
        for pattern in winPattern{
            let winPositions = pattern.subtracting(computerPositions)
            if winPositions.count == 1{
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first ?? 0)
                if isAvailable{return winPositions.first ?? 0}
            }
        }
        
        // Wenn es möglich ist, soll er beim nächsten Zug des Gegners den Spielverlust vermeiden
        let humanMoves = moves.compactMap{ $0 }.filter{ $0.player == .human}
        let humanPositions = Set(humanMoves.map {$0.boardIndex})
        
        for pattern in winPattern{
            let winPositions = pattern.subtracting(humanPositions)
            if winPositions.count == 1{
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first ?? 0)
                if isAvailable{return winPositions.first ?? 0}
            }
        }
        
        // Wenn er nicht blockieren kann, soll er das mittlere Feld nehmen
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare){
            return centerSquare
        }
        
        // Wenn er nicht die Mitte nehmen kann, soll er zufällig wählen
        var movePosition = Int.random(in: 0..<9)
        
        
        while isSquareOccupied(in: moves, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool{
        let winPattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map {$0.boardIndex})
        
        for pattern in winPattern where pattern.isSubset(of: playerPositions){
            return true
        }
        return false
    }
    func checkForDraw(in moves: [Move?]) -> Bool{
        return moves.compactMap{$0}.count == 9
    }
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
    }
    
}
