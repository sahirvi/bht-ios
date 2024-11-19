//
//  ContentView.swift
//  Postfix Calculator
//
//  Created by sahi on 01.11.21.
//
//  Tutorial für das Layout: https://www.youtube.com/watch?v=cMde7jhQlZI&t=1337s

import SwiftUI

enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case divide = "÷"
    case multiply = "×"
    case add = "+"
    case subtract = "-"
    case enter = "⏎"
    case clear = "C"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return .orange
        case .enter:
            return .green
        case .clear:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

struct ContentView: View {
    
    @State var displayValue = ""
    @State var enteredValues : [String] = []
    @State var userHasStartedTyping = false
    
    let buttons: [[CalculatorButton]] = [
        [.seven, .eight, .nine, .divide],
        [.four, .five, .six, .multiply],
        [.one, .two, .three, .add],
        [.zero, .enter, .clear, .subtract],
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    Text(displayValue)
                        .bold()
                        .font(.system(size: 150))
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.buttonPressed(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 35))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func buttonPressed(button: CalculatorButton) {
        switch button {
            
        case .clear:
            self.enteredValues.removeAll()
            print(enteredValues)
            self.displayValue = ""
            
        case .enter:
            if (enteredValues.isEmpty) {
                self.enteredValues.append(self.displayValue)
                print(enteredValues)
                userHasStartedTyping = false
            }
            
        case.divide:
            self.enteredValues.append(self.displayValue)
            print(enteredValues)
            if (enteredValues.count == 2) {
                let firstInput = self.enteredValues.removeFirst()
                let dividend = Int(firstInput) ?? 0
                let secondInput = self.enteredValues.removeLast()
                let divisor = Int(secondInput) ?? 0
                let quotient = dividend / divisor
                let result = String(quotient)
                self.displayValue = result
                enteredValues.append(result)
                userHasStartedTyping = false
                print(enteredValues)
            }
            
        case .multiply:
            self.enteredValues.append(self.displayValue)
            print(enteredValues)
            if (enteredValues.count == 2) {
                let firstInput = self.enteredValues.removeLast()
                let factor1 = Int(firstInput) ?? 0
                let secondInput = self.enteredValues.removeLast()
                let factor2 = Int(secondInput) ?? 0
                let product = factor1 * factor2
                let result = String(product)
                self.displayValue = result
                enteredValues.append(result)
                userHasStartedTyping = false
                print(enteredValues)
            }
            
        case .add:
            self.enteredValues.append(self.displayValue)
            print(enteredValues)
            if (enteredValues.count == 2) {
                let firstInput = self.enteredValues.removeLast()
                let addend1 = Int(firstInput) ?? 0
                let secondInput = self.enteredValues.removeLast()
                let addend2 = Int(secondInput) ?? 0
                let sum = addend1 + addend2
                let result = String(sum)
                self.displayValue = result
                enteredValues.append(result)
                userHasStartedTyping = false
                print(enteredValues)
            }
            
        case .subtract:
            self.enteredValues.append(self.displayValue)
            print(enteredValues)
            if (enteredValues.count == 2) {
                let firstInput = self.enteredValues.removeFirst()
                let minuend = Int(firstInput) ?? 0
                let secondInput = self.enteredValues.removeLast()
                let subtrahend = Int(secondInput) ?? 0
                let difference = minuend - subtrahend
                let result = String(difference)
                self.displayValue = result
                enteredValues.append(result)
                userHasStartedTyping = false
                print(enteredValues)
            }
            
        default:
            if (userHasStartedTyping == true){
                let number = button.rawValue
                self.displayValue = "\(self.displayValue)\(number)"
            }
            else {
                let number = button.rawValue
                self.displayValue = number
                userHasStartedTyping = true
            }
        }
    }
    
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (3*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (12)) / 4
    }
}
