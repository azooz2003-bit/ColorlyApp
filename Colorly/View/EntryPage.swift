//
//  EntryPage.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct EntryPage: View {
    @StateObject var tabBar: TabBar = TabBar()
    @EnvironmentObject var profile: Profile
    @EnvironmentObject var authentication: Authentication
    
    private let size = UIScreen.main.bounds
    
    var body: some View {
        TabView {
            
            ProfilePage().tabItem {
                ProfileIcon().font(.system(size: size.width*0.16, weight: .regular, design: .default)).environmentObject(tabBar).environmentObject(profile).onTapGesture {
                    tabBar.updateActiveTab(tab: "profile")
                }
            }
            
            ColorFeed().tabItem {
                FeedIcon().font(.system(size: size.width*0.15, weight: .regular, design: .default)).environmentObject(tabBar).environmentObject(profile).onTapGesture {
                    tabBar.updateActiveTab(tab: "feed")
                }
            }
            
            SettingsPage().tabItem {
                SettingsIcon().frame(width: size.width*0.1, alignment: .center).font(.system(size: size.width*0.15, weight: .regular, design: .default)).environmentObject(tabBar).environmentObject(profile).environmentObject(authentication).onTapGesture {
                    tabBar.updateActiveTab(tab: "settings")
                }
            }
            
        }
    }
}

struct EntryPage_Previews: PreviewProvider {
    static var previews: some View {
        EntryPage().environmentObject(SignUpViewModel()).environmentObject(LoginViewModel()).environmentObject(Authentication()).environmentObject(Profile())
    }
}
