//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by User on 25/05/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain{
    var bmi : BMI?
    
    
    mutating func calculateBMI(height: Float,weight: Float){
        let bmiValue = weight / (height * height)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: .blue )
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fir as a fiddle!", color: .green)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: .red)
        }
    }
    func getBMIValue() -> String{
        let StringBMI = String(format: "%.1f", bmi?.value ?? 0.0)
        return StringBMI

    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "Unknown advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .white
    }
}
