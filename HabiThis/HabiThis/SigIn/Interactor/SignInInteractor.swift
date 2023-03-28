//
//  SignInInteractor.swift
//  HabiThis
//
//  Created by user on 23/03/23.
//

import Foundation
import Combine

class SignInInteractor {
    private let remote: SignInRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension SignInInteractor {
    
    func login(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
