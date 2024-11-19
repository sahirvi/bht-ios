//
//  Alerts.swift
//  TicTacToe
//
//  Created by sahi on 10.11.21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title : Text
    var message: Text
    var buttonTitle: Text
}
struct AlertContext {
    static  let humanWin = AlertItem(title: Text("You've Won!"),
                                     message: Text("You're are so clever!"),
                                     buttonTitle: Text("Revenge?"))
    static   let computerWin = AlertItem(title: Text("You've Lost!"),
                                         message: Text("I'm so good"),
                                         buttonTitle: Text("Rematch!"))
    static  let draw = AlertItem(title: Text("It's a Draw!"),
                                 message: Text("We're on the same level"),
                                 buttonTitle: Text("Try Again!"))
}
