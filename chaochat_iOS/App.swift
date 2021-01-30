//
//  SceneDelegate.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import SwiftUI
import Firebase

@main
struct Chaochat: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AuthenticationService())
                .environmentObject(ScreenCoordinator())
        }
    }
}
