//
//  SignUpViewModel.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/2/22.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var credentials = Credentials()
    @Published var profile = Profile()
    @Published var showProgressView = false
    @Published var colorViews : [String: Bool] = ["Blue" : false, "Red" : false, "Green": false, "Pink" : false, "Yellow" : false]
    @Published var error: Authentication.AuthenticationError = .unknownError
    
    var signUpDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty || profile.displayName.isEmpty
    }
    
    func signUp(completion: @escaping (Bool) -> Void) { // I could add error to the parameter of completion
        showProgressView = true
        FirebaseService.shared.signUp(credentials: self.credentials, profile: self.profile) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
                case .success:
                    completion(true)
                    print("yyayyy")
                case .failure(let authError):
                    self.error = authError
                    completion(false)
                    print("nayyyy")
            }
        }
    }
    
    func setAvatar(avatar: String, completion: @escaping (Bool) -> Void) {
        self.profile.avatar = avatar
        showProgressView = true
        
        FirebaseService.shared.setAvatar(profile: self.profile) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
                case .success:
                    completion(true)
                    print("yyayyy")
                case .failure(let authError):
                    self.error = authError
                    completion(false)
                    print("nayyyy")
            }
        }
    }
    
    func setColor(color: String, completion: @escaping (Bool) -> Void) {
        self.profile.feedColor = color
        showProgressView = true
        colorViews[profile.feedColor] = true
        FirebaseService.shared.setColor(profile: self.profile) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            colorViews[profile.feedColor] = false
            switch result {
                case .success:
                    completion(true)
                    print("yyayyy")
                case .failure(let authError):
                    self.error = authError
                    completion(false)
                    print("nayyyy")
            }
        }
    }
    
}
