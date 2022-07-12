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

    var displayValue: Double {
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
    var isFinishedTypingNumber = true
    private var calculator = CalculatorLogic()
        
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        if let button = sender.currentTitle {
            if let result = calculator.calculate(symbol: button) {
                displayValue = result
            }
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let number = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = number
                isFinishedTypingNumber = false
            } else {
                if number == "." {
                    let isInt = floor(displayValue) == displayValue
                    if !isInt {
                        return
                    }
                }
                displayLabel.text! += number
            }
        }
    }
}

