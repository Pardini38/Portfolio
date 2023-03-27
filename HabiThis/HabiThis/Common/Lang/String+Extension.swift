//
//  String+Extension.swift
//  HabiThis
//
//  Created by user on 09/03/23.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF Matches %@", regEx).evaluate(with: self)
    }
}
