//
//  RgbVenn.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/28/22.
//

import SwiftUI

struct RgbVenn: View {
    
    var size = UIScreen.main.bounds
    var exists = false
    
    var body: some View {
        
        ZStack {
            Circle().frame(width: size.width*0.25, height: size.width*0.25, alignment: .center).foregroundColor(.blue).offset(y: size.width*0.13)
            
            Circle().frame(width: size.width*0.25, height:size.width*0.25, alignment: .trailing).foregroundColor(.green).offset(x: size.width*0.1)
            
            Circle().frame(width: size.width*0.25, height: size.width*0.25, alignment: .leading).foregroundColor(.red).offset(x: -size.width*0.1)

        }.padding(EdgeInsets.init(top: 0, leading: size.height*0.1, bottom: size.height*0.07, trailing: size.height*0.1))
    }
    
    func existsCheck(exists: Bool) {
        
    }
}

struct RgbVenn_Previews: PreviewProvider {
    static var previews: some View {
        RgbVenn()
    }
}
