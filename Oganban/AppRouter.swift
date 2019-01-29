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
    
    func openTabbar(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
        let tabBar = TabbarViewController()
        tabBar.selectedIndex = index
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
        guard let topVC = UIApplication.topViewController() else { return }
//        guard let key = aps["screen"] as? String else { return }
//        guard let id = aps["obj_id"] as? String else { return }
        let id = "142"
        let key = "ORDER_BUYER"
        let json = JSON(aps)
        print(json)
        
        
        switch key {
        case "ORDER_BUYER":
            let vc = MyBuyDetailRouter.createModule(orderId: id, isSaler: false)
            topVC.push(controller: vc)
        case "ORDER_SELLER":
            let vc = MyBuyDetailRouter.createModule(orderId: id, isSaler: true)
            topVC.push(controller: vc)
        case "RE_COMMENT":
            let vc = CommentDetailRouter.createModule(recordId: id)
            topVC.push(controller: vc)
        case "COMMENT":
            let vc = CommentDetailRouter.createModule(recordId: id)
            topVC.push(controller: vc)
        default:
           break
        }
    }
}
