//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    let eggTimes : [String:Int] = ["Soft":3,"Medium":4,"Hard":7]
    var count : Int = 0
    var timer = Timer()
    var secondsPassed = 0
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var textLabel: UILabel!
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
       
        let hardness = sender.currentTitle!
        count = 0
        secondsPassed = 0
        progressBar.progress = 0
        textLabel.text = "Doing a \(hardness) Hardness egg."
        timer.invalidate()

        count = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
       
        @objc func updateTimer() {
            if secondsPassed < count {
                
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(count)

            } else {
                textLabel.text! = "Done!"
                timer.invalidate()
                playSound()
            }
        }
    }
