//
//  BasePopUpViewCenter.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class BasePopUpViewCenter: UIView {
    let vBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var btnCover: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(btnCoverTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        addSubview(vBackground)
        vBackground.fillSuperview()
        vBackground.addSubview(btnCover)
        btnCover.fillSuperview()
        vBackground.addSubview(vContent)
    }
    
    @objc func btnCoverTapped() {
        hidePopUp()
    }
    
    func showPopUp() {
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(self)
            self.fillSuperview()
            self.vBackground.alpha = 0
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: UIView.AnimationOptions.curveEaseOut, animations: { [unowned self] in
                            self.vBackground.alpha = 1
                            self.vContent.widthAnchor.constraint(equalToConstant: window.frame.width - 100).isActive = true
                            self.vContent.centerSuperview()
                }, completion: nil)
        }
    }
    
    func hidePopUp(success: ((Bool) -> Void)? = nil) {
        self.vBackground.alpha = 1
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let strongSelf = self else {
                success?(false)
                return }
            
            strongSelf.vBackground.alpha = 0
            strongSelf.removeFromSuperview()
            success?(true)
        })
        
    }
}



