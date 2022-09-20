//
//  SignUpAuth.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/23/22.
//

import SwiftUI

struct SignUpAuth: View {
    @StateObject private var signUpVM = SignUpViewModel()
    @EnvironmentObject var authentication: Authentication
    @StateObject var UIState: UIStateModel = UIStateModel()
    
    private let size = UIScreen.main.bounds
    
    @State private var showAlert = false
    
    var body: some View {
        if authentication.signUpFielded && authentication.entryMethod != "none" {
            AvatarSelect().navigationBarBackButtonHidden(true).environmentObject(signUpVM).environmentObject(authentication).environmentObject(UIState)
            
        }
        else {
           
            VStack {
                RgbVenn()
                Group {
                    Text("Sign-up").fontWeight(Font.Weight.bold).font(.system(size: size.height*0.05, design: .rounded))
                    Text("Display Name").fontWeight(.bold).foregroundColor(.gray).frame(width: size.width*0.9, height: size.height*0.05, alignment: .leading).padding(.leading).font(Font.system(size: size.width*0.05))
                    TextField("John", text: $signUpVM.profile.displayName).frame(width: size.width*0.87, height: size.height*0.05, alignment: .leading).padding(.leading).font(.system(size: size.width*0.05, design: .rounded)).disableAutocorrection(true).autocapitalization(.none).keyboardType(.emailAddress)
                    Divider().padding(.leading)
                }
                Group {
                    Text("Email").fontWeight(.bold).foregroundColor(.gray).frame(width: size.width*0.9, height: size.height*0.05, alignment: .leading).padding(.leading).font(Font.system(size: size.width*0.05))
                    TextField("jsmith99@gmail.com" + "", text: $signUpVM.credentials.email).frame(width: size.width*0.87, height: size.height*0.05, alignment: .leading).padding(.leading).font(.system(size: size.width*0.05, design: .rounded)).disableAutocorrection(true).autocapitalization(.none).keyboardType(.emailAddress)
                    Divider().padding(.leading)
                }
                Group {
                    Text("Password").fontWeight(.bold).foregroundColor(.gray).frame(width: size.width*0.9, height: size.height*0.05, alignment: .leading).padding(.leading).font(Font.system(size: size.width*0.05))
                    SecureField("must contain 8+ characters", text: $signUpVM.credentials.password).frame(width: size.width*0.87, height: size.height*0.05, alignment: .leading).padding(.leading).font(.system(size: size.width*0.05, design: .rounded)).disableAutocorrection(true).autocapitalization(.none)
                    Divider().padding(.leading)
                }
                
                
                
                if !signUpVM.signUpDisabled {
                    
                    Button(action: {
                        signUpVM.signUp { success in
                            authentication.updateSignUpFielded(success: success)
                            if !success {
                                showAlert = true
                            } else {
                                authentication.updateEntryMethod(entryMethod: "sign-up")
                            }
                            print(success.description + ": success")
                        }
                    }) {
                        if signUpVM.showProgressView {
                            ProgressView().font(.system(size: size.width*0.15)).frame(width: size.width*0.9, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05).progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Label("", systemImage: "arrow.forward").font(.system(size: size.width*0.11)).foregroundColor(.white).frame(width: size.width*0.9, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05).shadow(radius: 4)
                        }
                        
                    }.padding(EdgeInsets.init(top: size.height*0.08, leading: 0, bottom: size.height*0.11, trailing: 0)).frame(width: size.width, height: size.height*0.15, alignment: .center).shadow(radius: 4).alert("Invalid field or error 404.", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { showAlert = false }
                    }
            
                } else {
                    Button(action: {
                       
                    }) {
                        Label("", systemImage: "arrow.forward").font(.system(size: size.width*0.11)).foregroundColor(.white).frame(width: size.width*0.9, height: size.height*0.08, alignment: .center).background(.black).cornerRadius(size.width*0.05)
                    }.padding(EdgeInsets.init(top: size.height*0.08, leading: 0, bottom: size.height*0.09
                                              , trailing: 0)).frame(width: size.width, height: size.height*0.15, alignment: .center).shadow(radius: 4).opacity(0.3)
                }
                
                
            }.frame(width: size.width*0.9, height: size.height, alignment: .center).onTapGesture {
                UIApplication.shared.endEditing()
            }.disabled(signUpVM.showProgressView).alert(signUpVM.error.localizedDescription, isPresented: $showAlert) {
                Button("OK", role: .cancel) { showAlert = false }
            }
            
            
        }
        
    }
}

struct SignUpAuth_Previews: PreviewProvider {
    static var previews: some View {
        SignUpAuth().environmentObject(Authentication())
    }
}
