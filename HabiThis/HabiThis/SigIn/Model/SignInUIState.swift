//
//  SignInUIState.swift
//  HabiThis
//
//  Created by user on 06/03/23.
//

import Foundation

enum SignInUIState: Equatable {
  case none
  case loading
  case goToHomeScreen
  case error(String)
}
