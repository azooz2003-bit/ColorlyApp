//
//  ContentCard.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct ContentCard: View {
    private let size = UIScreen.main.bounds
    
    var post: Post
    var color: String
    var text: String
    var avatar: String
    var user: String
    @State var numLikes: Int = 0
    
    init (color: String, text: String, avatar: String, user: String, numLikes: Int, post: Post) {
        self.post = post
        self.user = user
        self.color = color
        self.text = text
        self.avatar = avatar
        self.numLikes = post.numLikes
    }
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    ZStack {
                        Image(avatar).resizable().aspectRatio(0.7, contentMode: .fit).frame(width: size.width*0.07, alignment: .center)
                        Circle().strokeBorder(.black, lineWidth: 2).frame(width: size.width*0.1, height: size.height*0.19, alignment: .center).foregroundColor(.clear).shadow(radius: 4)
                    }.frame(width: size.width*0.05, height: size.width*0.1, alignment: .center)
                    Text(user).foregroundColor(.black).frame(width: size.width*0.9, height: size.height*0.05, alignment: .leading).padding(.leading).font(Font.system(size: size.width*0.05, weight: .medium, design: .rounded))
                    
                }.frame(width: size.width*0.9, height: size.height*0.05, alignment: .center).padding(EdgeInsets.init(top: 0, leading: size.width*0.15, bottom: 0, trailing: 0))
            }
            
            VStack {
                Group {
                    Text(text).fontWeight(Font.Weight.regular).foregroundColor(.white).padding(.init(top: size.height*0.02, leading: size.height*0.025, bottom: 0, trailing: size.height*0.025))
                    Button(action: {
                        post.updateNumLikes()
                        numLikes += 1
                    }) {
                        HStack {
                            Text(String(numLikes)).font(.system(size: size.width*0.04)).foregroundColor(.white)
                            Label("", systemImage: "hand.thumbsup.fill").font(.system(size: size.width*0.045)).foregroundColor(.white)
                            
                        }
                    }.padding(EdgeInsets.init(top: size.height*0.0001, leading: size.height*0.01, bottom: size.height*0.01, trailing: size.height*0.01))
                    
                }
            }.frame(width: size.width*0.9, alignment: .leading).background(Color(color + "Card")).cornerRadius(10).font(.system(size: size.height*0.02, design: .rounded)).shadow(radius: 4)
            
            
        }
        
    }
}

struct ContentCard_Previews: PreviewProvider {
    static var previews: some View {
        ContentCard(color: "Red", text: "Fun day.", avatar: "ShortyAvatar", user: "Aziz", numLikes: 1, post: Post(text: "heyy", id: 1))
    }
}
