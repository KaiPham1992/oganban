//
//  AppSwitch.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/26/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol AppSwitchDelegate: class {
    func changedStatus()
}

class AppSwitch: BaseView {
    let vBackground: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray
        return view
    }()
    
    let lbStatus: AppLabel = {
        let lb = AppLabel()
        lb.textColor = AppColor.white
//        lb.textAlignment = .right
//        lb.text = "Tắt"
        
        return lb
    }()
    
    let vMove: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.white
        return view
    }()
    
    lazy var btnAction: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
        return btn
    }()
    
    var isOn: Bool = true {
        didSet {
            moveSwitch()
        }
    }
    
    
    weak var delegate: AppSwitchDelegate?
    
    private func moveSwitch() {
        UIView.animate(withDuration: 0.3) {
            var x: CGFloat = 5
            let y: CGFloat = (self.frame.height - 20) / 2
            let width: CGFloat = 20
            let height: CGFloat = 20
            
            if self.isOn {
                x = self.frame.width - 25
                self.lbStatus.text = "Tắt"
                self.lbStatus.textAlignment = .left
            } else {
                x = 5
                self.lbStatus.text = "Mở"
                self.lbStatus.textAlignment = .right
            }
            
            self.vMove.frame =  CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    var leftVmove: NSLayoutConstraint?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moveSwitch()
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(vBackground)
        vBackground.addSubview(lbStatus)
        lbStatus.centerYToSuperview()
        lbStatus.anchor(left: vBackground.leftAnchor, right: vBackground.rightAnchor, leftConstant: 10, rightConstant: 10)
        
        addSubview(vMove)
        addSubview(btnAction)
        btnAction.fillSuperview()
        
        //--
        vBackground.anchor(heightConstant: 30)
        vBackground.fillHorizontalSuperview()
        vBackground.centerSuperview()
        vBackground.setBorder(cornerRadius: 15)
        
        //--
        vMove.anchor(widthConstant: 20, heightConstant: 20)
        vMove.centerYToView(view: self.vBackground)
        leftVmove = vMove.leftAnchor.constraint(equalTo: vBackground.leftAnchor, constant: 5)
        leftVmove?.isActive = true
        vMove.setBorder(cornerRadius: 10)
    }
    
    @objc func btnActionTapped() {
        isOn = !isOn
        delegate?.changedStatus()
    }
}
