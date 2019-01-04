//
//  AppRouter.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    func updateRootView() {
        if UserDefaultHelper.shared.isLoggedIn  {
            openTabbar()
        } else {
            setLanding()
        }
    }
    
    
    func setLanding() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
        let vcLogin = SignUpRouter.createModule()
        let nc = UINavigationController(rootViewController: vcLogin)
        windowApp.rootViewController = nc
    }
    
    func openTabbar() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
        let tabBar = TabbarViewController()
        windowApp.rootViewController = tabBar
    }
    
    func openTest() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
        let tabBar = PostStepOneRouter.createModule()
        windowApp.rootViewController = tabBar
    }
}
