//
//  SignUpViewRouter.swift
//  HabiThis
//
//  Created by user on 07/03/23.
//
import SwiftUI

enum SignUpViewRouter {
  
    static func makeHomeView() -> some View {
    let viewModel = HomeViewModel()
    return HomeView(viewModel: viewModel)
  }
}
