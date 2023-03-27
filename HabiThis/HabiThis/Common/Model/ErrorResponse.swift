//
//  SignUpResponse.swift
//  HabiThis
//
//  Created by user on 20/03/23.
//

import Foundation

struct ErrorResponse: Decodable {
    
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
