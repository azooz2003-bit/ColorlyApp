//
//  Post.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/17/22.
//

import Foundation
import SwiftUI

class Post: ObservableObject {
    var uid: Int
    var text: String
    @Published var numLikes: Int = 0
    
    @Published var showPostProgressView = false
    @Published var isPosted: Bool = false

    //var comments: [[String : String]] // uid : "3131", comment: "yooo"
    
    init(text: String, id: Int) {
        self.text = text
        self.uid = id
    }
    
    func updateNumLikes() {
        numLikes += 1;
        
    }
    
    func updateIsPosted(success: Bool) {
        withAnimation {
            isPosted = success
        }
    }
}
