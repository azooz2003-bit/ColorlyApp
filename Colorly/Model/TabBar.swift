//
//  TabBar.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import Foundation
import SwiftUI

class TabBar: ObservableObject {
    @Published var activeTab: String = "profile"
    
    func updateActiveTab(tab: String) {
        withAnimation {
            activeTab = tab
        }
    }
    
}
