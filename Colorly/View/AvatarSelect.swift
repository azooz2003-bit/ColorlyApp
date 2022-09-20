//
//  AvatarSelect.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/28/22.
//

import SwiftUI

struct AvatarSelect: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var UIState: UIStateModel
    
    @State var avatarSelected = false
    @State private var showAlert = false
    
    private let size = UIScreen.main.bounds
    private let avatars = ["ParrotAvatar", "ShrimpAvatar", "ShortyAvatar"]
    

    var body: some View {
        if avatarSelected {
            ColorSelect().environmentObject(authentication).environmentObject(signUpVM)
        }
        else {
            VStack {
                LinearGradient(gradient: Gradient(colors: [.white, .yellow, .green, .blue, .purple, .red]), startPoint: .trailing, endPoint: .leading).mask(
                    Text("Select Avatar").fontWeight(Font.Weight.bold).font(.system(size: size.height*0.05, design: .rounded)).frame(width: size.width, height: size.height*0.15, alignment: .center)
                ).frame(width: size.width, height: size.height*0.1, alignment: .center)
                //.shadow(color: .black, radius: 4, x: 0, y: 0).clipShape(Circle()).scaledToFit()
                FullCarousel()
                
                Button(action: {
                        print("pressed")
                        signUpVM.setAvatar(avatar: avatars[UIState.activeEllipse]) { success in
                                authentication.updateAvatarSelected(success: success)
                            print("Avatar update: " + "\(success)")
                            if !success {
                                showAlert = true
                            } else {
                                withAnimation {
                                    avatarSelected = true
                                }
                            }
                        }
                    
                    }
                ) {
                    if signUpVM.showProgressView {
                        ProgressView().font(.system(size: size.width*0.11)).frame(width: size.width*0.9, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05).progressViewStyle(CircularProgressViewStyle(tint: .white)).padding(EdgeInsets.init(top: size.height*0.05, leading: 0, bottom: size.height*0.05, trailing: 0)).shadow(radius: 4)
                    } else {
                        Label("", systemImage: "arrow.forward").font(.system(size: size.width*0.11)).foregroundColor(.white).frame(width: size.width*0.9, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05).padding(EdgeInsets.init(top: size.height*0.05, leading: 0, bottom: size.height*0.05, trailing: 0)).shadow(radius: 4)
                    }
                }.disabled(signUpVM.showProgressView).alert(signUpVM.error.localizedDescription, isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }
                
                
                
                    //.frame(width: size.width - ((size.width*0.04)*2) - ((size.width*0.195)*2), height: item._id == UIState.activeCard ? size.width - ((size.width*0.04)*2) - ((size.width*0.195)*2) : size.width - ((size.width*0.04)*2) - ((size.width*0.195)*2) - 60, alignment: .center)
                    //.frame(width: size.width, height: size.height*0.5, alignment: .center)
            }
        }
        
        
    }
}

struct AvatarSelect_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelect().environmentObject(UIStateModel()).environmentObject(SignUpViewModel()).environmentObject(Authentication())
    }
}
