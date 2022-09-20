//
//  PublicPosts.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/18/22.
//

import Foundation

class PublicPosts: ObservableObject {
    static var update = PublicPosts()
    
    func getPosts(profile: Profile, color: String, completion: @escaping (Bool) -> Void) {
        FirebaseService.shared.getPosts(color: color, profile: profile) { [unowned self](result: Result<Bool, Profile.ProfileError>) in
            switch result {
                case .success:
                    completion(true)
                    print("yyayyy")
                case .failure(let postError):
                    profile.error = postError
                    completion(false)
                    print("nayyyy")
            }
            
        }
    }
}
