//
//  Authentication.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/30/22.
//

import Foundation
import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    @Published var signUpFielded = false
    @Published var avatarSelected = false
    @Published var colorFielded: Bool = false
    @Published var entryMethod: String = "none"
    @Published var loggedIn: Bool = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case shortPassword
        case isTaken
        case unknownError
        case badEmail
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
                case .invalidCredentials:
                    return NSLocalizedString("Either your email or password are incorrect. Please try again.", comment: "")
                case .shortPassword:
                    return NSLocalizedString("Password is too short. Please try again.", comment: "")
                case .isTaken:
                    return NSLocalizedString("Email is taken. Please try again.", comment: "")
                case .unknownError:
                    return NSLocalizedString("Unknown error, please try again or restart the application.", comment: "")
                case .badEmail:
                    return NSLocalizedString("Email is in wrong format.", comment: "")
                
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
    
    func updateSignUpFielded(success: Bool) {
        withAnimation {
            signUpFielded = success
        }
    }
    
    func updateAvatarSelected(success: Bool) {
        withAnimation {
            avatarSelected = success
        }
    }
    
    func updateColorFielded(success: Bool) {
        withAnimation {
            colorFielded = success
        }
    }
    
    func updateEntryMethod(entryMethod: String) {
        withAnimation {
            self.entryMethod = entryMethod
        }
    }
}
