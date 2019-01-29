//
//  AppRouter.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SwiftyJSON


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
    
    func handleNotification(userInfo: [AnyHashable : Any]) {
        guard let aps = userInfo["aps"] as? [String: Any]  else { return }
        guard let key = aps["screen"] as? String else { return }
        guard let id = aps["obj_id"] as? String else { return }
        let json = JSON(aps)
        print(json)
        switch key {
        case "ORDER_BUYER":
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
            let vc = OrderBuyDetailRouter.createModule(recordId: id)
            windowApp.rootViewController = vc
        case "ORDER_SELLER":
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
            let vc = OrderDetailRouter.createModule(recordId: id)
            windowApp.rootViewController = vc
        case "RE_COMMENT":
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
            let vc = CommentDetailRouter.createModule(recordId: id)
            windowApp.rootViewController = vc
        case "COMMENT":
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
            let vc = CommentDetailRouter.createModule(recordId: id)
           windowApp.rootViewController = vc
        default:
            openTabbar()
        }
    }
}
