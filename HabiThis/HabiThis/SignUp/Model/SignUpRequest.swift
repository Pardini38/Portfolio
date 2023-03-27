//
//  SignUpRequest.swift
//  HabiThis
//
//  Created by user on 15/03/23.
//

import Foundation

struct SignUpRequest: Encodable {

    let name: String
    let email: String
    let password: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
