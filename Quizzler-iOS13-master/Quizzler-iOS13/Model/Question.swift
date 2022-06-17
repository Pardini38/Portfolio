//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by User on 23/05/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

struct Question {
    let text : String
    let answer : [String]
    let correctAnswer : String
    
    
    init(q: String, a: [String], correctAnswer: String){
        self.text = q
        self.answer = a
        self.correctAnswer = correctAnswer
    }
}
