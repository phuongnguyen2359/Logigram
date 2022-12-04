//
//  LoginViewModel.swift
//  Logigram
//
//  Created by TT on 12/2/22.
//

import RxCocoa

enum LoginError: Error {
    case invalidUser
    
    var errorMsg: String {
        switch self {
        case .invalidUser:
            return "Invalid Email or Password"
        }
    }
}

final class LoginViewModel {
    
    enum LoginState {
        case loading
        case completed
        case loginError(LoginError)
        case idle
    }
        
    let loginStateRelay = BehaviorRelay<LoginState>(value: .idle)
    
    /// Check email/password valid
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    /// - Returns: Bool
    func signIn(email: String, password: String) {
        //call network
        guard email == "admin@gmail.com" && password == "admin" else {
            return loginStateRelay.accept(.loginError(LoginError.invalidUser))
        }
        loginStateRelay.accept(.completed)
    }
}
