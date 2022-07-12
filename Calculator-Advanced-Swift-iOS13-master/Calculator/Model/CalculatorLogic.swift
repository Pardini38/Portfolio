//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by user on 11/07/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {

    private var number: Double?
    var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double?) {
        self.number = number
    }
    
    mutating func calculate(symbol: String) -> Double? {
        guard let n = number else { return Double() }
        switch symbol {
        case "AC":
            return 0
        case "+/-":
            print("+/-")
            return n * -1
        case "%":
            print("%")
            return n * 0.01
        case "=":
            print("=")
            return performTwoNumberCalculation(n2: n)
        default:
            print(symbol)
            intermediateCalculation = (n1: n, calcMethod: symbol)
        }
        
        return n
    }
    
    private func performTwoNumberCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default: break
            }
        }
        return nil
    }
}
