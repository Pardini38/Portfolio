//
//  SignInViewModel.swift
//  HabiThis
//
//  Created by user on 03/03/23.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private var cancellableRequest: AnyCancellable?
    
    private let publisher = PassthroughSubject<Bool, Never>()
    private let interactor: SignInInteractor
    
    @Published var email = ""
    @Published var password = ""
    @Published var uiState: SignInUIState = .none
    
    init(interactor: SignInInteractor) {
        self.interactor = interactor
        
        cancellable = publisher.sink { value in
            print("Usuário criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
        cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email,
                                                                          password: password))
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch (completion) {
            case .failure(let appError):
                self.uiState = SignInUIState.error(appError.message)
                break
            case .finished:
                //self.uiState = .goToHomeScreen
                break
                
            }
        } receiveValue: { success in
            print(success)
            self.interactor.insertAuth(userAuth: UserAuth(idToken: success.accessToken,
                                                          refreshToken: success.refreshToken,
                                                          expires: success.expires,
                                                          tokenType: success.tokenType))
            self.uiState = .goToHomeScreen
        }
    }
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}
