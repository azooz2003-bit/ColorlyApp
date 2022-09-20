//
//  SettingsPage.swift
//  Colorly
//
//  Created by Abdulaziz Albahar on 9/10/22.
//

import SwiftUI

struct SettingsPage: View {
    @EnvironmentObject var tabBar: TabBar
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var signUpVM: SignUpViewModel
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
