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
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGoogle()
        //---
        IQKeyboardManager.shared.enable = true
        configurePushNotification(application: application)
        
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        window?.frame = UIScreen.main.bounds
        UIApplication.shared.statusBarStyle = .lightContent
        
        
//        checkGPS()
        
        checkLogin()
//        AppRouter.shared.openTest()
        AppRouter.shared.openTabbar()
        //        let vcLogin = OrderDetailRouter.createModule()
        //        let nc = UINavigationController(rootViewController: vcLogin)
        //        window?.rootViewController = nc
//        UserDefaultHelper.shared.saveLocation(lat: CLLocationDegrees(10.737938), long: CLLocationDegrees(106.677911), address: "180 Đường Cao Lỗ, Phường 4, Quận 8, Hồ Chí Minh, Vietnam")
        return true
    }
    
    func checkLogin() {
        Provider.shared.userAPIService.checkLogin(success: { _ in
            
        }) { _error in
            UserUtils.clearLogin()
        }
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let fb = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        let gg = GIDSignIn.sharedInstance().handle(url as URL?,
                                                   sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                   annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return fb || gg
        
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        checkLogin()
        
        guard let topView = UIApplication.topViewController() else { return }
        if topView is CheckGPSViewController {
            topView.viewWillAppear(true)
        }
    }
    
}

