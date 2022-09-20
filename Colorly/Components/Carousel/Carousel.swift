//
//  CarouselView.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/4/22.
//

import SwiftUI

public class UIStateModel: ObservableObject {
    @Published var activeEllipse: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct Carousel<Items: View> : View {
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenEllipses: CGFloat
    let totalSpacing: CGFloat
    let ellipseWidth: CGFloat
    
    private let size = UIScreen.main.bounds
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenEllipses: CGFloat,
        @ViewBuilder _ items: () -> Items) {
            self.items = items()
            self.numberOfItems = numberOfItems
            self.spacing = spacing
            self.widthOfHiddenEllipses = widthOfHiddenEllipses
            self.totalSpacing = (numberOfItems-1) * spacing
            self.ellipseWidth = UIScreen.main.bounds.width - (widthOfHiddenEllipses*2) - (spacing*2)
        }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (ellipseWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenEllipses + spacing
        let totalMovement = ellipseWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeEllipse))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement*CGFloat(UIState.activeEllipse) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
            print("\(activeOffset)" + "active offset")
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }.offset(x: CGFloat(calcOffset), y: 0).gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            
            if (currentState.translation.width < -50) && !(activeOffset < 0 && UIState.activeEllipse == 2) || !(activeOffset > size.width*0.08 && UIState.activeEllipse == 0) && (currentState.translation.width > 50) {
                print(UIState.activeEllipse)
                self.UIState.screenDrag = Float(currentState.translation.width)
            }
                            
            print("\(currentState.translation.width)" + "is new pos. And active offset is" + "\(activeOffset)")
                        
        }.onEnded { value in
            self.UIState.screenDrag = 0
            
                if (value.translation.width < -50) && !(activeOffset < 0 && UIState.activeEllipse == 2) {
                    self.UIState.activeEllipse += 1
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    print("added from Active")
                }
                
                if !(activeOffset > size.width*0.08 && UIState.activeEllipse == 0) && (value.translation.width > 50) {
                    self.UIState.activeEllipse -= 1
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    print("subtracted from Active")
                }
            
        })
        
    }
    
    struct Canvas<Content: View>: View {
        let content : Content
        @EnvironmentObject var UIState: UIStateModel
        
        @inlinable public init(@ViewBuilder _ content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            content.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
    
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        Text("prev").environmentObject(UIStateModel())
    }
}
