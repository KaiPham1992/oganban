//
//  TabbarViewController.swift
//  String96
//
//  Created by Ngoc Duong on 12/18/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import Foundation

import UIKit

let tabIconInsets = UIEdgeInsets(top: 0, left: 0, bottom: -4, right: 0)
let tabBarIncrease: CGFloat = 13

class TabbarViewController: UITabBarController {
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    weak var tabbarDelagate: TabbarProtocol?
    var listViewController = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setUpTabbar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var newTabBarHeight: CGFloat = 0
        if Utils.isIphoneXOrLater() {
            newTabBarHeight = defaultTabBarHeight + tabBarIncrease
        } else {
            newTabBarHeight = defaultTabBarHeight
        }
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.barTintColor = UIColor.white
        tabBar.frame = newFrame
       
    }
    
    func setUpTabbar() {
        navigationItem.setHidesBackButton(true, animated: true)
        let vcHome = HomeRouter.createModule()
        
        let vcMyBuy = MyBuyRouter.createModule()
        let vcMySell = MySellContainerRouter.createModule()
        let vcNotification = NotificationRouter.createModule()
        let vcMore = MoreRouter.createModule()
        
        vcHome.tabBarItem = setBarItem(selectedImage: AppImage.imgHomeSelected.withRenderingMode(.alwaysOriginal), normalImage: AppImage.imgHome.withRenderingMode(.alwaysOriginal))
        vcHome.tabBarItem.title  = "Trang chủ"
        vcHome.tabBarItem.tag = 1
        
        vcMyBuy.tabBarItem = setBarItem(selectedImage: AppImage.imgMyBuySelected.withRenderingMode(.alwaysOriginal), normalImage: AppImage.imgMyBuy.withRenderingMode(.alwaysOriginal))
        vcMyBuy.tabBarItem.title = "Tôi mua"
        vcMyBuy.tabBarItem.tag = 2

        vcMySell.tabBarItem = setBarItem(selectedImage: AppImage.imgMySellSelected.withRenderingMode(.alwaysOriginal), normalImage: AppImage.imgMySell.withRenderingMode(.alwaysOriginal))
        vcMySell.tabBarItem.title = "Tôi bán"
        vcMySell.tabBarItem.tag = 3

        vcNotification.tabBarItem = setBarItem(selectedImage: AppImage.imgNotificationSelected.withRenderingMode(.alwaysOriginal), normalImage: AppImage.imgNotification.withRenderingMode(.alwaysOriginal))
        vcNotification.tabBarItem.title = "Thông báo"
        vcNotification.tabBarItem.tag = 4

        vcMore.tabBarItem = setBarItem(selectedImage: AppImage.imgMoreSelected.withRenderingMode(.alwaysOriginal), normalImage: AppImage.imgMore.withRenderingMode(.alwaysOriginal))
        vcMore.tabBarItem.title = "Xem thêm"
        vcMore.tabBarItem.tag = 5
        
        listViewController = [vcHome, vcMyBuy, vcMySell, vcNotification, vcMore]
        
        for controller in listViewController {
            controller.tabBarItem.imageInsets = tabIconInsets
        }
        
        let selectedColor   = UIColor(red: 0/255.0, green: 88.0/255.0, blue: 0/255.0, alpha: 1.0)
        let unselectedColor = UIColor.gray
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
//        if UIDevice.current.isIphoneXOrLater() == true {
//            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
//        } else {
//            UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
//        }
        
        self.tabBar.tintColor = UIColor.white
        addViewControllerToTabbar(listViewController: listViewController)
    }
    
    func addViewControllerToTabbar(listViewController: [UIViewController]) {
        var listNavigationController = [UINavigationController]()
        for vc in listViewController {
//            vc.view.backgroundColor = .red
//            let nc = UINavigationController()
//            nc.viewControllers = [vc]
//            nc.navigationItem.backBarButtonItem = UIBarButtonItem.back(nil, action: nil)
            
            let nc = UINavigationController(rootViewController: vc)
            listNavigationController.append(nc)
        }
        
        self.viewControllers = listNavigationController
    }
    
    func setBarItem(title: String? = nil, selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: normalImage, selectedImage: selectedImage)
        return item
    }
}

extension TabbarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabbarDelagate?.tabbarSelected(index: tabBarController.selectedIndex)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let itemView =  self.tabBar.subviews[item.tag]
        let itemImageView = itemView.subviews.first as! UIImageView
        itemImageView.contentMode = .center
        
        self.playBounceAnimation(itemImageView)
    }
    
    func playBounceAnimation(_ icon: UIImageView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.5)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        
        icon.layer.add(bounceAnimation, forKey: nil)
    }
}
