//
//  SettingsIcon.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct SettingsIcon: View {
    private let size = UIScreen.main.bounds
    
    var body: some View {
        Label("", systemImage: "gearshape.fill").font(.system(size: size.width*0.15, weight: .regular, design: .default)).frame(width: size.width*0.15, alignment: .center)
    }
}

struct SettingsIcon_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIcon()
    }
}
