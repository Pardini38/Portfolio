//
//  SignUpUIState.swift
//  HabiThis
//
//  Created by user on 07/03/23.
//

import Foundation

enum SignUpUIState: Equatable {
  case none
  case loading
  case success
  case error(String)
}
