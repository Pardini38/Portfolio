//
//  SignUpView.swift
//  HabiThis
//
//  Created by user on 06/03/23.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("SignUp")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        nameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthdayField
                        genderField
                        enterButton
                    }
                    Spacer()
                }.padding(.horizontal, 8)
            }.padding()
            
            if case SignUpUIState.error(let errorMsg) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habithis"),message: Text(errorMsg), dismissButton: .default(Text("ok")){})
                    }
            }
        }
    }
    
}

extension SignUpView {
    
    var nameField: some View {
        EditTextView(text: $viewModel.name,
                     placeholder: "Full Name",
                     keyboard: .alphabet,
                     error: "Invalid name",
                     failure: viewModel.name.count < 3)
    }
    
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "E-mail",
                     error: "Invalid e-mail",
                     failure: !viewModel.email.isEmail())
    }
    
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Password",
                     error: "Must contains at least 6 characters",
                     failure: viewModel.password.count < 6,
                     isSecure: true)
    }
    
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "ID",
                     error: "invalid ID",
                     failure: viewModel.document.count != 11)
        //TODO: cpf mask
        //TODO: isDisabled
    }
    
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeholder: "Phone",
                     keyboard: .numberPad,
                     error: "Phone number invalid",
                     failure: viewModel.phone.count < 10 || viewModel.phone.count >= 12)
    }
    
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Birth date (dd/mm/yyyy)",
                     keyboard: .default,
                     error: "Invalid birth date",
                     failure: viewModel.birthday.count != 10)
        //TODO: mask
    }
    
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
    
    var enterButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        },
                          text: "Register",
                          disabled: !viewModel.email.isEmail() || viewModel.password.count < 6 || viewModel.name.count < 3 || viewModel.document.count != 11 || viewModel.phone.count < 10 || viewModel.phone.count >= 12 || viewModel.birthday.count != 10,
                          showProgress: self.viewModel.uiState == SignUpUIState.loading)
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SignUpViewModel(interactor: SignUpInteractor())
        SignUpView(viewModel: viewModel)
    }
}
