//
//  AvatarEllipse.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/3/22.
//

import SwiftUI

struct AvatarItem: View {
    @EnvironmentObject var UIState: UIStateModel
    //@EnvironmentObject var signUpVM: SignUpViewModel
    let ellipseWidth: CGFloat
    let ellipseHeight: CGFloat
    
    var _id: Int
    
    private let size = UIScreen.main.bounds
    private var avatar: String
    private var width = 0

    init (avatar: String, _id: Int, spacing: CGFloat, widthOfHiddenEllipses: CGFloat) {
        self._id = _id
        self.avatar = avatar
        self.ellipseWidth = size.width - (widthOfHiddenEllipses*2) - (spacing*2)
        self.ellipseHeight = ellipseWidth
    }
    
    var body: some View {
        ZStack {
            Image(avatar).resizable().aspectRatio(0.7, contentMode: .fit).frame(width: ellipseWidth*0.68, alignment: .center).padding(.leading)
            Circle().strokeBorder(.black, lineWidth: 5).frame(width: ellipseWidth, alignment: .center).foregroundColor(.clear).shadow(radius: 4)
            //Image(avatar).resizable().aspectRatio(0.7, contentMode: .fit).frame(width: size.width*0.43, height: size.width*0.44, alignment: .center)
            //Circle().frame(width: size.width*0.43, height: size.height*0.3, alignment: .center).foregroundColor(.clear).overlay(Circle().stroke(Color.black, lineWidth: 4)).shadow(radius: 4)
                
        //size.width*0.44
        }
    }
}

struct AvatarEllipse_Previews: PreviewProvider {
    static var previews: some View {
        AvatarItem(avatar: "ShrimpAvatar", _id: 0, spacing: UIScreen.main.bounds.width*0.195, widthOfHiddenEllipses: UIScreen.main.bounds.width*0.04)
    }
}
