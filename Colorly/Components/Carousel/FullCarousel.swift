//
//  FullCarousel.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/4/22.
//

import SwiftUI

struct FullCarousel: View {
    @EnvironmentObject var UIState: UIStateModel
    private let size = UIScreen.main.bounds
    
    var body: some View {
        let spacing: CGFloat = size.width*0.195//size.width*0.04
        let widthOfHiddenEllipses: CGFloat = size.width*0.04
        
        let items = [
            Ellipse(id: 0, name: "ParrotAvatar"),
            Ellipse(id: 1, name: "ShrimpAvatar"),
            Ellipse(id: 2, name: "ShortyAvatar")
        ]
        
        
        Carousel(numberOfItems: CGFloat(items.count), spacing: spacing, widthOfHiddenEllipses: widthOfHiddenEllipses) {
                ForEach(items, id: \.self.id) { item in
                    AvatarItem(avatar: item.name, _id: item.id, spacing: CGFloat(spacing), widthOfHiddenEllipses: widthOfHiddenEllipses).frame(height: size.height*0.4, alignment: .center)
                }
        }
        
        
    }
}

struct FullCarousel_Previews: PreviewProvider {
    static var previews: some View {
        FullCarousel().environmentObject(UIStateModel())
    }
}
