//
//  ColorSelect.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/6/22.
//

import SwiftUI

struct ColorSelect: View {
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var authentication: Authentication
        
    private let size = UIScreen.main.bounds
    private var colorLabels: [ColorButton] = [ColorButton(color: .red, text: "Red", id: 0), ColorButton(color: .blue, text: "Blue", id: 1), ColorButton(color: .green, text: "Green", id: 2), ColorButton(color: .pink, text: "Pink", id: 3), ColorButton(color: .yellow, text: "Yellow", id: 4)]
    
    @State private var spring = 0
    @State private var showAlert = false
    
    
   

    var body: some View {
        if authentication.colorFielded {
            EntryPage().environmentObject(signUpVM).environmentObject(authentication).environmentObject(signUpVM.profile)
        } else {
            
            VStack {
                LinearGradient(gradient: Gradient(colors: [.white, .yellow, .green, .blue, .purple, .red]), startPoint: .trailing, endPoint: .bottom).mask(
                    Text("Select your\ncolor feed").fontWeight(Font.Weight.bold).font(.system(size: size.height*0.04, design: .rounded)).frame(width: size.width, height: size.height*0.13, alignment: .center).multilineTextAlignment(.center)
                ).frame(width: size.width, height: size.height*0.09, alignment: .center)
                Text("FYI: Your choice cannot be changed later on.").fontWeight(Font.Weight.medium).font(.system(size: size.height*0.018, design: .rounded)).frame(width: size.width, height: size.height*0.02, alignment: .center).padding(.top)
                
                
                
                ForEach(colorLabels, id: \.self.id) { label in
                    
                    Button(action: {
                       
                        signUpVM.setColor(color: label.text) { success in
                            authentication.updateColorFielded(success: success)
                            if !success {
                                showAlert = true
                            }
                        }
                    }) {
                        label
                    }.disabled(signUpVM.showProgressView).alert(signUpVM.error.localizedDescription, isPresented: $showAlert) {
                        Button("OK", role: .cancel) { }
                    }
                }
                
                
                
                
            }.padding(EdgeInsets.init(top: 0, leading: 0, bottom: size.height*0.08, trailing: 0)).padding(.top)
        }
        
        
    }
}

struct ColorSelect_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelect().environmentObject(Authentication()).environmentObject(SignUpViewModel())
    }
}
