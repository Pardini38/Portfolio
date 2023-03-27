//
//  HomeView.swift
//  HabiThis
//
//  Created by user on 06/03/23.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var viewModel: HomeViewModel
  
  var body: some View {
    Text("Página Home")
  }
}

struct HomeView_Preview: PreviewProvider {
  static var previews: some View {
    let viewModel = HomeViewModel()
    HomeView(viewModel: viewModel)
  }
}
