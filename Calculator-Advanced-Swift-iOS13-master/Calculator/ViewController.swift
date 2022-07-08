//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var calcList: [String] = []
    private var lastIsOperator: Bool = true
    private  var isFinishedTypingNumber: Bool = true
    private var displayValue: Double {
        get {
            guard let currentDisplay = Double(displayLabel.text!) else { fatalError("Display cannot converted to Double.") }
        return currentDisplay
        }
        set {
            if floor(newValue) == newValue {
                displayLabel.text = String(Int(newValue))
            } else {
                displayLabel.text = String(newValue)
            }
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        if let display = displayLabel.text {
            
            guard var displayD = Double(display) else { return }
            guard let button = sender.currentTitle else { return }
            switch button {
            case "AC":
                print("AC")
                displayLabel.text = "0"
                calcList = []
            case "+/-":
                print("+/-")
                if displayD != 0.0 {
                    displayD *= -1.0
                }
                displayUpdate(String(displayD))
            case "%":
                displayD /= 100
                displayUpdate(String(displayD))
            case "÷":
                print("÷")
                if lastIsOperator == false {
                    calcList.append(display)
                    calcList.append("/")
                    lastIsOperator = true
                }
            case "×":
                print("×")
                if lastIsOperator == false {
                    calcList.append(display)
                    calcList.append("*")
                    lastIsOperator = true
                }
            case "-":
                print("-")
                if lastIsOperator == false {
                    calcList.append(display)
                    calcList.append("-")
                    lastIsOperator = true
                }
            case "+":
                print("+")
                if lastIsOperator == false {
                    calcList.append(display)
                    calcList.append("+")
                    lastIsOperator = true
                }
            case "=":
                calcList.append(display)
                while calcList.count > 1 {
                    guard let op1: Double = Double(calcList[0]) else { fatalError("calcList[0] não é número") }
                    guard let op2: Double = Double(calcList[2]) else { fatalError("calcList[2] não é número") }
                    switch calcList[1] {
                    case "/":
                        calcList.insert(String(op1 / op2), at: 0)
                    case "*":
                        calcList.insert(String(op1 * op2), at: 0)
                    case "-":
                        calcList.insert(String(op1 - op2), at: 0)
                    case "+":
                        calcList.insert(String(op1 + op2), at: 0)
                    default:
                        fatalError("operador não listado.")
                    }
                    for _ in 1...3 {
                        calcList.remove(at: 1)
                    }
                }
                lastIsOperator = false
                displayUpdate(calcList.first ?? "0")
                calcList = []
            default:
                print("N/A")
            }
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        lastIsOperator = false
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                if numValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    if !isInt { return }
                    
                }
                displayLabel.text?.append(contentsOf: numValue)
            }
        }
    }
    
    func displayUpdate(_ tVar: String) {
        guard let tVar = Double(tVar) else { return }
        if tVar.rounded() - tVar == 0.0 {
            displayLabel.text = String(Int(tVar))
        } else {
            displayLabel.text = String(tVar)
        }
    }
}

