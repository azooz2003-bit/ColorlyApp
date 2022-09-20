//
//  ColorFeed.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct ColorFeed: View {
    @StateObject var tabBar: TabBar = TabBar()
    @EnvironmentObject var profile: Profile
    @EnvironmentObject var authentication: Authentication
    
    @State var newPost = ""
    @State private var showAlert = false
    private let size = UIScreen.main.bounds
    
    var body: some View {
        let color = profile.feedColor
        let avatar = profile.avatar
        let name = profile.displayName
        

        VStack {
            Text(color.lowercased()).font(.system(size: size.height*0.042,weight: .bold , design: .rounded)).foregroundColor(.white).frame(width: size.width*0.85, height: size.height*0.07, alignment: .center).background(LinearGradient(gradient: Gradient(colors: [.orange, Color(color + "Card"), Color(color + "Card"), Color(color + "Card"), .orange]), startPoint: .leading, endPoint: .trailing )).cornerRadius(10).shadow(radius: 2).padding(.init(top: 0, leading: 0, bottom: size.height*0.08, trailing: 0)).shadow(color: Color(color + "Card"), radius: 40, x: 0, y: 10)
            
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    //ForEach
                    ForEach(profile.posts, id: \.self.uid) { post in
                        ContentCard(color: color, text: post.text, avatar: avatar, user: name, numLikes: post.numLikes, post: post).padding(.top)
                    }
                }
            }.frame(width: size.width, height: size.height*0.45, alignment: .center)
            if #available(iOS 16.0, *) {
                TextField("Enter a Text", text: $newPost, axis: .vertical)
                    .multilineTextAlignment(.leading)
                    .frame(height: size.height*0.05, alignment: .center)
                    .padding()
                    .background(.white)
                    .cornerRadius(7)
                    .foregroundColor(.black).shadow(radius: 7)
            } else {
                TextField("Enter a Text", text: $newPost)
                    .frame(height: size.height*0.08, alignment: .center)
                    .padding()
                    .background(.white)
                    .cornerRadius(7)
                    .foregroundColor(.black).shadow(radius: 7)
            }
            Button(action: {
                let post = Post(text: newPost, id: profile.posts.count)
                profile.addPost(post: post) { success in
                    post.updateIsPosted(success: success)
                    
                    if success {
                        PublicPosts.update.getPosts(profile: profile, color: color) { success in
                           
                        }
                    } else {
                        showAlert = true
                    }
                }
            }) {
                Label("", systemImage: "plus.circle.fill").font(.system(size: size.width*0.2)).foregroundColor(Color(color + "Card"))
            }.alert(profile.error.localizedDescription, isPresented: $showAlert) {
                Button("OK", role: .cancel) { showAlert = false }
            }
            
        }.padding(.bottom)
        
        
        
    }
}

struct ColorFeed_Previews: PreviewProvider {
    static var previews: some View {
        ColorFeed().environmentObject(SignUpViewModel()).environmentObject(Profile())
    }
}
