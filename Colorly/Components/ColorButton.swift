//
//  ColorButton.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/6/22.
//

import SwiftUI

struct ColorButton: View {
    private let size = UIScreen.main.bounds
    
    public var color: Color
    public var text: String
    public var id: Int
    
    @EnvironmentObject var signUpVM: SignUpViewModel
    
    init(color: Color, text: String, id: Int) {
        self.color = color
        self.text = text
        self.id = id
    }

    var body: some View {
        ZStack {
            
            Circle()
                .strokeBorder(LinearGradient(gradient: Gradient(colors: [.gray, .green, .yellow, .green, .red, .purple, .green, .yellow]), startPoint: .trailing, endPoint: .leading),lineWidth: 3)
                .background(Circle().foregroundColor(color)).frame(width: size.height*0.12, height: size.height*0.15, alignment: .center)
            if signUpVM.showProgressView && signUpVM.colorViews[text]! {
                ProgressView().foregroundColor(.white).font(.system(size: size.height*0.035, design: .rounded)).progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Text(text).foregroundColor(.white).font(.system(size: size.height*0.035, design: .rounded))
            }
        }.padding(.top).frame(width: size.height*0.14, height: size.height*0.14, alignment: .center).shadow(radius: 4)
    }

}

struct ColorButton_Previews: PreviewProvider {
    static var previews: some View {
        ColorButton(color: Color.blue, text: "Blue", id: 0).environmentObject(SignUpViewModel())
    }
    
}
