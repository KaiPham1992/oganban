//
//  ProgressView.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/2/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit


open class ProgressView {
    
    let vcontainer: UIView = {
        let v = UIView()
        v.backgroundColor = AppColor.backgroundItem
        
        return v
    }()
    
    let vIndicator: KActivityIndicatorView = {
        let view = KActivityIndicatorView(type: KActivityIndicatorType.ballClipRotateMultiple)
        
        return view
    }()
    
    
    public static let shared = ProgressView()
    
    private func show(_ view: UIView) {
        
        view.addSubview(vcontainer)
        vcontainer.centerSuperview()
        vcontainer.anchor(widthConstant: 80, heightConstant: 80)
        vcontainer.setBorderWithCornerRadius(cornerRadius: 10)
        //---
        vcontainer.addSubview(vIndicator)
        vIndicator.anchor(widthConstant: 60, heightConstant: 60)
        vIndicator.centerSuperview()
        vIndicator.startAnimating()
    }
    
    open func show() {
       
        DispatchQueue.main.async {
            guard let view = UIApplication.topViewController()?.view else { return }
            self.show(view)
        }
    }
    
    func showProgressOnWindow() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else  { return }
            self.show(window)
        }
    }
    
    open func hide() {
        DispatchQueue.main.async {
            self.vcontainer.removeFromSuperview()
            self.vIndicator.removeFromSuperview()
        }
        
    }
}
