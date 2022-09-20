//
//  LandingPage.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/17/22.
//

import SwiftUI

struct LandingPage: View {
    let size = UIScreen.main.bounds
    @StateObject var authentication: Authentication  = Authentication()
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var signUpVM = SignUpViewModel()

    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image("Landing").scaledToFit().edgesIgnoringSafeArea(.all)
                
                    
                VStack(spacing: size.height*0.02) {
                    
                    NavigationLink(destination: SignUpAuth().environmentObject(authentication), label: { Text("Sign-up").fontWeight(Font.Weight.medium).font(.system(size: size.height*0.035, design: .rounded)).frame(width: size.width*0.95, height: size.height*0.09, alignment: .center).foregroundColor(Color.black).background(Color.white).cornerRadius(size.width*0.07, antialiased: true).shadow(radius: 4)
                        
                    })
                    
                    NavigationLink(destination: LoginAuth().environmentObject(authentication), label: {
                        Text("Login").fontWeight(Font.Weight.medium).font(.system(size: size.height*0.035, design: .rounded)).scaledToFill().frame(width: size.width*0.95, height: size.height*0.09, alignment: .center).foregroundColor(Color.black).background(Color.white).cornerRadius(size.width*0.07, antialiased: true).shadow(radius: 4)
                            
                    })
                    
                    
                    
                    
                    
                }.frame(width: size.width, height: size.height*0.5, alignment: .bottom).offset(x: 0, y: size.width*0.3).padding(.bottom)
                    
            }
        }
       
        
        
        
    }
    

struct LandingPage_Previews:    PreviewProvider {
        static var previews: some View {
            Group {
                LandingPage()
                LandingPage()
                    .previewDevice("iPhone 11")
                    .previewInterfaceOrientation(.portrait)
            }
        }
    }
}
