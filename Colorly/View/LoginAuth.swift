//
//  LoginAuth.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/23/22.
//

import SwiftUI
import Firebase

struct LoginAuth: View {
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    
    private let size = UIScreen.main.bounds
    
    @State private var showAlert = false
    @State var authenticated = false
    //@State var errorMessage = "Invalid field or error 404."
    
    var body: some View {
        
        if authentication.isValidated {
            EntryPage().environmentObject(authentication).environmentObject(loginVM.profile).navigationBarBackButtonHidden(true)
        }
        else {
            VStack {
                RgbVenn()
                Text("Login").fontWeight(Font.Weight.bold).font(.system(size: size.height*0.05, design: .rounded))
                Text("Email").fontWeight(.bold).foregroundColor(.gray).frame(width: size.width*0.9, height: size.height*0.05, alignment: .leading).padding(.leading).font(Font.system(size: size.width*0.05))
                TextField("jsmith99@gmail.com ", text: $loginVM.credentials.email).frame(width: size.width*0.87, height: size.height*0.05, alignment: .leading).padding(.leading).font(.system(size: size.width*0.05, design: .rounded)).disableAutocorrection(true).autocapitalization(.none).keyboardType(.emailAddress)
                Divider().padding(.leading)
                Text("Password").fontWeight(.bold).foregroundColor(.gray).frame(width: size.width*0.9, height: size.height*0.05, alignment: .leading).padding(.leading).font(Font.system(size: size.width*0.05))
                SecureField("must contain 8+ characters", text: $loginVM.credentials.password).frame(width: size.width*0.87, height: size.height*0.05, alignment: .leading).padding(.leading).font(.system(size: size.width*0.05, design: .rounded)).disableAutocorrection(true).autocapitalization(.none)
                Divider().padding(.leading)
                
                
                
                if !loginVM.loginDisabled {
                    
                    Button(action: {
                        loginVM.login { success in
                            authentication.updateValidation(success: success)
                            if !success {
                                showAlert = true
                            }
                            print(success.description + ": success")
                        }
                    }) {
                        if loginVM.showProgressView {
                            ProgressView().font(.system(size: size.width*0.11)).frame(width: size.width*0.32, height: size.height*0.08, alignment: .center).frame(width: size.width*0.32, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05).progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Label("", systemImage: "arrow.forward").font(.system(size: size.width*0.11)).foregroundColor(.white).frame(width: size.width*0.32, height: size.height*0.08, alignment: .center).frame(width: size.width*0.32, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05)
                        }
                        
                    }.padding(EdgeInsets.init(top: size.height*0.07, leading: 0, bottom: size.height*0.02, trailing: 0)).frame(width: size.width, height: size.height*0.15, alignment: .center).shadow(radius: 4)
                } else {
                    Button(action: {
                       
                    }) {
                        Label("", systemImage: "arrow.forward").font(.system(size: size.width*0.11)).foregroundColor(.white).frame(width: size.width*0.32, height: size.height*0.08, alignment: .center).frame(width: size.width*0.32, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05)
                    }.padding(EdgeInsets.init(top: size.height*0.07, leading: 0, bottom: size.height*0.02, trailing: 0)).frame(width: size.width, height: size.height*0.15, alignment: .center).shadow(radius: 4).opacity(0.3)
                }
                
                
            }.frame(width: size.width*0.9, height: size.height, alignment: .center).onTapGesture {
                UIApplication.shared.endEditing()
            }.disabled(loginVM.showProgressView).alert(loginVM.error.localizedDescription, isPresented: $showAlert) {
                Button("OK", role: .cancel) { print(showAlert
                ) }
            }
        }
        
        
        
    }
    
    
    
}

struct LoginAuth_Previews: PreviewProvider {
    static var previews: some View {
        LoginAuth().environmentObject(Authentication())
    }
}
