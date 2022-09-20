//
//  Profile.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/2/22.
//

import Foundation
import SwiftUI

class Profile: ObservableObject { // MAKE CODABLE?
    @Published var displayName: String = ""
    @Published var avatar: String = ""
    @Published var feedColor: String = "Red"
    @Published var uid: String = ""
    @Published var posts: [Post] = [Post(text: "Jamesss how's it been", id: 0)]
    @Published var error: ProfileError = .unknownError
        
    enum ProfileError: Error, LocalizedError, Identifiable {
        case emptyPost
        case maxCapacity
        case unknownError
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String? {
            switch self {
                case .emptyPost:
                    return NSLocalizedString("Post can't be empty, please type something to proceed.", comment: "")
                    
                    
                case .maxCapacity:
                    return NSLocalizedString("Post is too long, make sure to keep it under 200 characters.", comment: "")
                    
                case .unknownError:
                    return NSLocalizedString("Unknown fetch error.", comment: "")
            }
                
        }
    }
    
    func addPost(post: Post, completion: @escaping (Bool) -> Void) {
        self.posts.append(post)
        post.showPostProgressView = true
        
        FirebaseService.shared.addPost(profile: self) { [unowned self](result: Result<Bool, ProfileError>) in
            post.showPostProgressView = false
            
            switch result {
                case .success:
                    completion(true)
                    print("yyayyy")
                case .failure(let postError):
                    self.error = postError
                    completion(false)
                    print("nayyyy")
            }
        }
        
    }
    
    
    
}
