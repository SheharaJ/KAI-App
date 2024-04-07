//
//  KAI_APPApp.swift
//  KAI-APP
//
//  Created by Shehara Jayasooriya on 2024-03-31.
//

import SwiftUI

@main
struct KAI_APPApp: App {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
            
                    LoginView()
                .environmentObject(authenticationViewModel)
                }
        
    }
}
