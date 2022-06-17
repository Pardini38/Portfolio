//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {

        guard let userAnswer = sender.currentTitle else { return }
        let userGotItRight = quizBrain.checkAnswer( userAnswer )
        
        sender.backgroundColor = userGotItRight ? .green : .red
        
        quizBrain.nextQuestion()

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            self.updateUI()
        }
    }
    
    func updateUI() {
        let questionAnswers = quizBrain.getAnswers()
        button1.setTitle(questionAnswers[0], for: .normal)
        button2.setTitle(questionAnswers[1], for: .normal)
        button3.setTitle(questionAnswers[2], for: .normal)
        questionLabel.text = quizBrain.getQuestionText()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        button1.backgroundColor = UIColor.clear
        button2.backgroundColor = UIColor.clear
        button3.backgroundColor = UIColor.clear
        progressBar.progress = quizBrain.getProgress()
    }
}
