//
//  AppPageView.swift
//  String96
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class AppPageView: BaseView {
    let vMenu: AppPageMenu = {
        let menu = AppPageMenu()
        
        return menu
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        page.delegate = self
        page.dataSource = self
        return page
    }()
    
    var controllers = [UIViewController]() {
        didSet {
            if controllers.count <= 0 {
                return
            }
            
            //--
            pageViewController.setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    var currentIndexPageView = 0
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(pageViewController.view)
        addSubview(vMenu)
        vMenu.anchor(self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, rightConstant: 0, heightConstant: 40)
        vMenu.delegate = self
        
        pageViewController.view.anchor(vMenu.bottomAnchor, left: vMenu.leftAnchor, bottom: self.bottomAnchor, right: vMenu.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotatedDevice), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpMenuAndController(controllers: [UIViewController], menuColorBackground: UIColor, menuFont: UIFont, menuColorNormal: UIColor, menuColorSelected: UIColor, menuColorHorizontal: UIColor, heightHorizontal: CGFloat, listItem: [KCategory], isFull: Bool = false, isHaveLineTop: Bool = false) {
        
        vMenu.setUpViewMenu(menuColorBackground: menuColorBackground, menuFont: menuFont, menuColorNormal: menuColorNormal, menuColorSelected: menuColorSelected, menuColorHorizontal: menuColorHorizontal, heightHorizontal: heightHorizontal, listItem: listItem, isFull: isFull, isHaveLineTop: isHaveLineTop)
        self.controllers = controllers
    }
    
    @objc func rotatedDevice() {
        self.vMenu.cvMenu.collectionViewLayout.invalidateLayout()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.vMenu.scrollToIndex(index: self.currentIndexPageView)
        }
    }
}

extension AppPageView:  AppPageMenuDelegate {
    func itemMenuSelected(index: Int) {
        let viewController = controllers[index]
        var forward: UIPageViewController.NavigationDirection = .forward
        
        if index < currentIndexPageView {
            forward = .reverse
        }
        
        currentIndexPageView = index
        pageViewController.setViewControllers([viewController], direction: forward, animated: true, completion: nil)
    }
}

extension AppPageView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else { return nil }
        if index == controllers.count - 1 { return nil }
        let nextIndex = abs((index + 1) % controllers.count)
        
        return controllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else { return nil }
        if index == 0 { return nil }
        let previousIndex = abs((index - 1) % controllers.count)
        return controllers[previousIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
}

extension AppPageView: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?[0] else { return }
        guard let index = controllers.index(of: viewController) else { return }
        
        vMenu.scrollToIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
}
