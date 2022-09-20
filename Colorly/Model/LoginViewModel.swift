//
//  LoginViewModel.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/29/22.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var credentials = Credentials()
    @Published var profile = Profile() //@Published
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError = .unknownError
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        FirebaseService.shared.login(credentials: credentials, profile: profile) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            print("yooo")
            switch result {
                case .success:
                    completion(true)
                    print("yyayyy")
                case .failure(let authError):
                    credentials = Credentials()
                    self.error = authError
                    completion(false)
                    print("nayyyy")
            }
        }
    }
}
