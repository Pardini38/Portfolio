//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by User on 25/05/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.1 // pq começa no 10%
    var numberOfPeople = 2 // pq começa no 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        guard let buttonTitle = sender.currentTitle else { return }
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        guard let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign) else { return }
        
        tip = buttonTitleAsNumber / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        guard let bill = billTextField.text else { return }
        if bill != ""{
            billTotal = Double(bill)!
            let result = billTotal * (1+tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            guard let destinationVC = segue.destination as? ResultsViewController else { return }
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }

}
