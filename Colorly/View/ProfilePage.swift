//
//  MainPage.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/29/22.
//

import SwiftUI

struct ProfilePage: View {
    @StateObject var tabBar: TabBar = TabBar()
    @EnvironmentObject var profile: Profile
    @EnvironmentObject var authentication: Authentication
    
    private let size = UIScreen.main.bounds
    
    var body: some View {
        let avatar = profile.avatar
        let name = profile.displayName
        let color = profile.feedColor
        
        VStack {
            HStack {
                ZStack {
                    Image(avatar).resizable().aspectRatio(0.7, contentMode: .fit).frame(width: size.width*0.25, alignment: .center).padding(.leading)
                    Circle().strokeBorder(.black, lineWidth: 5).frame(width: size.width*0.35, height: size.height*0.19, alignment: .center).foregroundColor(.clear).shadow(radius: 4)
                }.frame(width: size.width*0.4, height: size.width*0.4, alignment: .leading)
                VStack(alignment: .center, spacing: size.height*0.015) {
                    Text(name).fontWeight(Font.Weight.medium).font(.system(size: size.height*0.04, design: .rounded))
                    Text(color.lowercased()).fontWeight(Font.Weight.medium).font(.system(size: size.height*0.042, design: .rounded)).foregroundColor(.white).frame(width: size.width*0.45, height: size.height*0.06, alignment: .center).background(LinearGradient(gradient: Gradient(colors: [.orange, Color(color + "Card"), Color(color + "Card"), Color(color + "Card"), .orange]), startPoint: .leading, endPoint: .trailing )).cornerRadius(20).shadow(radius: 4)
                }
            }
            Divider().frame(height: size.width*0.002).background(Color(color + "Card")).padding(.init(top: size.height*0.02, leading: 0, bottom: size.height*0.02, trailing: 0))
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(profile.posts, id: \.self.uid) { post in
                        ContentCard(color: color, text: post.text, avatar: avatar, user: name, numLikes: 1, post: post).padding(.top)
                    }
                }
            }.frame(width: size.width, height: size.height*0.65, alignment: .center)
            
            
        }
        
        
        
        if authentication.entryMethod == "sign-up" {
            
        } else if authentication.entryMethod == "login" {
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage().environmentObject(Authentication()).environmentObject(Profile())
    }
}
