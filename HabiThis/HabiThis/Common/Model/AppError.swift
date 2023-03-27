//
//  AppError.swift
//  HabiThis
//
//  Created by user on 23/03/23.
//

import Foundation

enum AppError: Error {
    case response(message: String)
        
    public var message: String {
        switch self {
        case .response(message: let message):
            return message
        }
    }
}
