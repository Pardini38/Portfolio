//
//  SignInView.swift
//  HabiThis
//
//  Created by user on 03/03/23.
//

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    @State var action: Int? =  0
    @State var navigationHidden = false
    
    var body: some View {
        ZStack {
            if case SignInUIState.goToHomeScreen = viewModel.uiState {
                viewModel.homeView()
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 20) {
                            Spacer(minLength: 36)
                            VStack(alignment: .center, spacing: 8) {
                                Image("logo")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.horizontal, 48)
                                
                                Text("Login")
                                    .foregroundColor(Color.green)
                                    .font(Font.system(.title).bold())
                                    .padding(.bottom, 8)
                                
                                loginField
                                
                                passwordField
                                
                                enterButton
                                
                                registerLink
                                
                                Text("Copyright @Gui_pardini 2022")
                                    .foregroundColor(Color.gray)
                                    .font(Font.system(size: 11).bold())
                                    .padding(.top, 16)
                            }
                        }
                        if case SignInUIState.error(let errorMsg) = viewModel.uiState {
                            Text("")
                                .alert(isPresented: .constant(true)) {
                                    Alert(title: Text("Habithis"),message: Text(errorMsg), dismissButton: .default(Text("ok")){})
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 32)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Login")
                    .navigationBarHidden(navigationHidden)
                }
                .onAppear(){
                    self.navigationHidden = true
                }.onDisappear() {
                    self.navigationHidden = false
                }
            }
        }
        
    }
}

extension SignInView {
    
    var loginField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     keyboard: .emailAddress,
                     error: "E-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
    
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Password",
                     error: "Senha deve ter 6 caracteres",
                     failure: viewModel.password.count < 6,
                     isSecure: true)
    }
    
    var enterButton: some View {
        
        LoadingButtonView(action: {
            viewModel.login()
        }, text: "Entrar", disabled: !viewModel.email.isEmail() || viewModel.password.count < 6, showProgress: self.viewModel.uiState == SignInUIState.loading)
    }
    
    var registerLink: some View {
        VStack {
            Text("Ainda não possui conta?")
                .foregroundColor(Color.gray)
                .padding(.top, 48)
            
            ZStack {
                NavigationLink(destination: viewModel.signUpView(),
                               tag: 1,
                               selection: $action,
                               label: {EmptyView()})
                
                Button("Cadastrar") {
                    self.action = 1
                }
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        SignInView(viewModel: viewModel)
    }
}
