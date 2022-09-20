//
//  ProfileIcon.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct ProfileIcon: View {
    private let size = UIScreen.main.bounds
    
    var body: some View {
        Label("", systemImage: "person.crop.circle.fill").font(.system(size: size.width*0.12, weight: .regular, design: .default))
    }
}

struct ProfileIcon_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIcon()
    }
}
