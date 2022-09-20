//
//  FeedIcon.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct FeedIcon: View {
    private let size = UIScreen.main.bounds

    var body: some View {
        Label("", systemImage: "person.2.wave.2.fill").font(.system(size: size.width*0.12, weight: .regular, design: .default))
    }
}

struct FeedIcon_Previews: PreviewProvider {
    static var previews: some View {
        FeedIcon()
    }
}
