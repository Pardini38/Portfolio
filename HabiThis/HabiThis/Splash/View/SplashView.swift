//
//  SplashView.swift
//  HabiThis
//
//  Created by user on 02/03/23.
//

import SwiftUI

struct SplashView: View {
  
  @ObservedObject var viewModel: SplashViewModel
  
  var body: some View {
    Group {
      switch viewModel.uiState {
      case .loading:
        loadingView()
      case .goToSignInScreen:
        viewModel.signInView()
      case .goToHomeScreen:
        Text("Tela principal")
      case .error(let Error):
        loadingView(Error)
      }
    }.onAppear {
      viewModel.onAppear()
    }
  }
}

extension SplashView {
  func loadingView(_ error: String? = nil) -> some View {
    ZStack {
      Image("logo")
        .resizable()
        .scaledToFit()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
        .ignoresSafeArea()
      
      if let error = error {
        Text("")
          .alert(isPresented: .constant(true)) {
            Alert(title: Text("Habithis"),message: Text(error), dismissButton: .default(Text("ok")){
              //faz algo quando some o alert
            })
          }
      }
    }
  }
}


struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
      let viewModel = SplashViewModel(interactor: SplashInteractor())
    SplashView(viewModel: viewModel)
  }
}
