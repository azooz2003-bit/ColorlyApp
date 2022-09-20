//
//  ContentView.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/6/22.
//

import SwiftUI

struct SplashScreen: View {
    @StateObject var authentication = Authentication()
    @State private var isActive: Bool = false
    @State private var opacity = 0.0
    @State private var overallOpacity = 1.0

    var body: some View {
        let markdownTitle: LocalizedStringKey = "colorTalks"
        
        if isActive {
            if authentication.isValidated {
                ProfilePage().environmentObject(authentication)
            } else {
                LandingPage()
            }
            
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .yellow, .green, .blue, .purple, .red]), startPoint: .bottom, endPoint: .trailing ).ignoresSafeArea()
                
                
                GeometryReader { metrics in
                    
                    let dim = metrics.size
                    
                    Text(markdownTitle).font(.system(size: metrics.size.height * 0.05, design: .rounded)).fontWeight(Font.Weight.bold).foregroundColor(Color.white).frame(maxWidth: .infinity, alignment: .center).padding(EdgeInsets.init(top: dim.height*0.6, leading: 0, bottom: 0, trailing: 0)).opacity(opacity).onAppear {
                        withAnimation(.easeIn(duration: 0.8)) {
                            self.opacity = 1
                        }
                    }
                }
                
            }.opacity(overallOpacity).onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    
                    self.isActive = true
                }
            }
        }
        
        
        
        
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
