//
//  SplashViewModel.swift
//  HabiThis
//
//  Created by user on 03/03/23.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                } else if (Date().timeIntervalSince1970 > userAuth!.expires) {
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: RefreshRequest(token: userAuth!.refreshToken))
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: {success in
                                self.interactor.insertAuth(userAuth: UserAuth(idToken: success.accessToken,
                                                                              refreshToken: success.refreshToken,
                                                                              expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                                              tokenType: success.tokenType))
                                self.uiState = .goToHomeScreen
                        })
                } else {
                    self.uiState = .goToHomeScreen
                }
            }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.uiState = .goToSignInScreen
        }
    }
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
