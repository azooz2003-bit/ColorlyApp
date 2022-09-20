//
//  FirebaseService.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/29/22.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class FirebaseService {
    static let shared = FirebaseService()
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    var postRef : DocumentReference? = nil
    
    
    func login(credentials: Credentials, profile: Profile, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Auth.auth().signIn(withEmail: credentials.email, password: credentials.password) { (result, error) in
                // more errors up here
                
                if error != nil {
                    completion(.failure(.invalidCredentials))
                } else {
                    let profile = profile
                    profile.displayName = (result?.user.displayName)!
                    profile.uid = (result?.user.uid)!
                    
                    self.db.collection("users").document(Auth.auth().currentUser!.uid).getDocument() { snap, err in
                        if err != nil {
                            completion(.failure(.unknownError))
                        } else {
                            //profile.feedColor = snap!["feedColor"] as! String
                            //profile.avatar = snap!["avatar"] as! String
                             
                            completion(.success(true))
                        }
                    }
                    
                                        
                }
            }
        }
    }
    
    func signUp(credentials: Credentials, profile: Profile, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if credentials.password.count < 8 {
                    completion(.failure(.shortPassword))
                    print("short password")
                } else if !self.isEmail(email: credentials.email) {
                    completion(.failure(.badEmail))
                } else if error != nil {
                    completion(.failure(.isTaken))
                    print(error?.localizedDescription ?? "error, taken")
                } else {
                    //completion(.success(true))
                    print("registration success")
                    self.ref = self.db.collection("users").document(Auth.auth().currentUser!.uid)
                    self.ref?.setData([
                        "name" : profile.displayName,
                        "uid" : Auth.auth().currentUser!.uid
                    ]) { err in
                        if let err = err {
                            print("error adding document, " + err.localizedDescription)
                            completion(.failure(.unknownError))
                            
                        } else {
                            completion(.success(true))
                        }
                    }
                    //self.ref = self.db.collection("users").document(Auth.auth().currentUser!.uid)
                    
                    let profile = profile
                    profile.uid = Auth.auth().currentUser!.uid
                }
                
            }
            
            // store name
            
        }
    }
    
    func isEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func setAvatar(profile: Profile, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { // SHall I use .then in parent func?
            self.ref?.updateData(["avatar" : profile.avatar]) { err in
                if let err = err {
                    print("error adding document, " + err.localizedDescription)
                    completion(.failure(.unknownError))
                    
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
    func setColor(profile: Profile, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.ref?.updateData(["color" : profile.feedColor]) { err in
                if let err = err {
                    print("error adding document, " + err.localizedDescription)
                    completion(.failure(.unknownError))
                    
                } else {
                    completion(.success(true))
                }
            }
        }
    }
    
    func addPost(profile: Profile, completion: @escaping (Result<Bool, Profile.ProfileError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if profile.posts.last!.text.isEmpty {
                completion(.failure(.emptyPost))
                print("post is empty")
            } else if profile.posts.last!.text.count > 199 {
                completion(.failure(.maxCapacity))
            } else {
                self.postRef = self.db.collection(profile.feedColor + "Posts").document(String(Auth.auth().currentUser!.uid))
                self.postRef?.setData([
                    "ownerUID" : profile.uid,
                    "content" : profile.posts.last?.text ?? "empty post",
                    "numLikes" : profile.posts.last?.numLikes ?? 0,
                    "id" : profile.posts.last?.uid ?? 0
                ]) { err in
                    if let err = err {
                        print("error adding document, " + err.localizedDescription)
                        completion(.failure(.unknownError))
                        
                    } else {
                        completion(.success(true))
                    }
                }
                self.postRef = self.db.collection("users").document(String(Auth.auth().currentUser!.uid))
                self.postRef?.updateData([
                    "posts" :
                        [[ "ownerUID" : profile.uid,
                          "content" : profile.posts.last?.text ?? "empty post",
                          "numLikes" : profile.posts.last?.numLikes ?? 0,
                          "id" : profile.posts.last?.uid ?? 0
                        ]]
                ]) { err in
                    if let err = err {
                        print("error adding document, " + err.localizedDescription)
                        completion(.failure(.unknownError))
                        
                    } else {
                        completion(.success(true))
                    }
                }
            }
            
            
        }
    }
    func getPosts(color: String, profile: Profile, completion:  @escaping (Result<Bool, Profile.ProfileError>) -> Void) {
        var posts: [Post] = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.db.collection(color + "Posts").getDocuments(source: .default) { (query, err) in
                if let err = err {
                    print("error adding document, " + err.localizedDescription)
                    completion(.failure(.unknownError))
                    
                } else if !query!.isEmpty {
                    for document in query!.documents {
                        let data = document.data()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            posts.append(Post(text: data["content"] as! String, id: data["id"] as! Int))
                        }
                    }
                }
            }
            profile.posts = posts
            
        }
        
        
        
        
    }
}
