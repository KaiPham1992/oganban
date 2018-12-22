//
//  AppDelegate.swift
//  Oganban
//
//  Created by Coby on 12/16/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain/Users/kaipham/Documents/Freelancer/oganban/Oganban
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //---
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        configurePushNotification(application: application)
        
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        window?.frame = UIScreen.main.bounds
        UIApplication.shared.statusBarStyle = .lightContent
        configureGoogle()
        
        AppRouter.shared.openTabbar()
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let fb = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let gg = GIDSignIn.sharedInstance().handle(url as URL?,
                                                   sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                   annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return fb || gg
    }
    
}

