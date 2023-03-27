//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by user on 22/07/22.
//

import UIKit

class Refeicao: NSObject {
    let name: String
    let happiness: Int
    let items: Array<Item> = []
    
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
    }
    
    func totalDeCalorias() -> Double {
        var total = 0.0
        for item in items {
            total += item.calory
        }
        return total
    }
}
