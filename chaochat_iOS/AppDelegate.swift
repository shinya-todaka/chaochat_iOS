//
//  AppDelegate.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/21.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: SignInView())
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

}

