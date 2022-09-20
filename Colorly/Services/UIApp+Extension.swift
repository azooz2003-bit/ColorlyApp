//
//  UIApp+Extension.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 8/29/22.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

    }
}
