//
//  PopUpNotification.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class PopUpNotification: BasePopUpView {
    lazy var vNotification: PopUpNotificationContent = {
        let v = PopUpNotificationContent()
        v.btnAccept.addTarget(self, action: #selector(btnAcceptTapped), for: .touchUpInside)
        return v
    }()
    
    override func setupView() {
        super.setupView()
        self.vContent.addSubview(vNotification)
        vNotification.fillSuperview()
    }
    
//    func showPopUp(message: String, title: String? = nil, titleAction: String? = nil,  width: CGFloat = 350, height: CGFloat = 270) {
//        // title
//        if title == nil {
//            self.vNotification.lbTitle.text = AppString.Title.notification.showLanguage.uppercased()
//        } else {
//            self.vNotification.lbTitle.text = title
//        }
//        
//        // title action
//        if titleAction == nil {
//            self.vNotification.btnAccept.setTitle(AppString.Title.accept.showLanguage, for: .normal)
//        } else {
//            self.vNotification.btnAccept.setTitle(titleAction&.showLanguage, for: .normal)
//        }
//        
//        self.vNotification.lbMessage.text = message.showLanguage
//        super.showPopUp(width: width, height: height)
//    }
    
    @objc func btnAcceptTapped() {
        self.hidePopUp()
    }
}
