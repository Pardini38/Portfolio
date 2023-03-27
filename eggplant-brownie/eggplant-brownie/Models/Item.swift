//
//  Item.swift
//  eggplant-brownie
//
//  Created by user on 22/07/22.
//

import UIKit

class Item: NSObject {
    let name: String
    let calory: Double
    
    init(name: String, calory: Double) {
        self.name = name
        self.calory = calory
    }
}
