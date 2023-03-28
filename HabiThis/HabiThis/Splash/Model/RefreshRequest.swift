//
//  RefreshRequest.swift
//  HabiThis
//
//  Created by user on 28/03/23.
//

import Foundation

struct RefreshRequest: Encodable {

    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
