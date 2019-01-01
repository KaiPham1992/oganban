//
//  BaseViewController.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation
import UIKit

enum StyleNavigation {
    case left
    case right
}

class BaseViewController: UIViewController {
    
    let mainBackgroundColor = UIColor.white
    let mainNavigationBarColor = AppColor.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        setUpViews()
    }
    
    let lbNoData: UILabel = {
        let lb = UILabel()
        lb.text = "Không có dữ liệu"
        lb.textColor = AppColor.black414141
        return lb
    }()
    
    func showNoData() {
        lbNoData.removeFromSuperview()
        self.view.addSubview(lbNoData)
        lbNoData.centerSuperview()
    }
    
    func hideNoData() {
        lbNoData.removeFromSuperview()
    }
    
    func setUpViews(){
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Connectivity.isConnectedToInternet()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func setUpNavigation() {
        self.view.backgroundColor = UIColor.white
        guard let navigationController = self.navigationController else { return }
        //---
        navigationController.navigationBar.barTintColor = mainNavigationBarColor
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = false
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setRedStatusBar() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
        statusBar.backgroundColor = AppColor.red
        UIApplication.shared.statusBarStyle = .lightContent
        statusBar.tintColor =  AppColor.red
    }
    
    func setWhiteStatusBar() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
        statusBar.backgroundColor = .white
        UIApplication.shared.statusBarStyle = .default
    }
    
}

// MARK: Add button left, right, title
extension BaseViewController {
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func setTitleImageNavigation(image: UIImage) {
        let view = UIView()
        let imageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 9, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        self.navigationItem.titleView = view
    }
    
    func addTwoButtonToNavigation(image1: UIImage, action1: Selector?, image2: UIImage, action2: Selector?) {
        let btn1 = UIButton()
        btn1.setImage(image1, for: .normal)
        if let _action = action1 {
            btn1.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        btn1.contentHorizontalAlignment = .right
        let button1 = UIBarButtonItem(customView: btn1)
        
        //---
        let btn2 = UIButton()
        btn2.setImage(image2, for: .normal)
        if let _action = action2 {
            btn2.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn2.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn2.contentHorizontalAlignment = .right
        
        let button2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.rightBarButtonItems = [button1, button2]
    }
    
    func addButtonTextToNavigation(title: String, style: StyleNavigation, action: Selector?, textColor: UIColor = UIColor.white) {
        let btn = UIButton()
        
        var _title = title
        if style == .right {
            _title = title
        }
        
        btn.setAttributed(title: _title, color: textColor, font: UIFont.systemFont(ofSize: 17))
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func setTitleNavigation(title: String, textColor: UIColor = UIColor.white, action: Selector? = nil ) {
        let lb = UILabel()
        lb.text             = title
        lb.textAlignment    = .center
        lb.numberOfLines    = 2
        lb.textColor        = textColor
        lb.sizeToFit()
        
        let tap = UITapGestureRecognizer(target: self, action: action)
        lb.addGestureRecognizer(tap)
        let vTest = UIView()
        vTest.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        vTest.addSubview(lb)
        lb.centerSuperview()
        self.navigationItem.titleView = vTest
    }
    
    func addButtonImageToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        btn.imageView?.contentMode = .scaleAspectFit
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 20)
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 0)
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
}
extension BaseViewController {
    func addBackToNavigation() {
        addButtonImageToNavigation(image: AppImage.imgBack, style: .left, action: #selector(btnBackTapped))
    }
    
    func addCloseToNavigation() {
        addButtonImageToNavigation(image: AppImage.imgExit, style: .left, action: #selector(btnCloseTapped))
    }
    
    @objc func btnCloseTapped() {
        self.dismiss()
    }
    
    @objc func btnBackTapped() {
        self.pop()
    }
}

extension BaseViewController {
    func addKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc func keyboardWillHide() {
        
    }
}
