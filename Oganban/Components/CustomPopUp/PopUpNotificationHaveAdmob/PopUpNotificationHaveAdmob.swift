//
//  PopUpNotificationHaveAdmob.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class PopUpNotificationHaveAdmob: BasePopUpView {
    lazy var vHaveAdmob: PopUpNotificationHaveAdmobContent = {
        let v = PopUpNotificationHaveAdmobContent()
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
//        v.admobNativeView.delegate = self
        return v
    }()
    
    var completionClose: CompletionClosure?
    override func setupView() {
        super.setupView()
        vContent.addSubview(vHaveAdmob)
        vHaveAdmob.fillSuperview()
    }
    
    func showPopUp(message: String) {
        let width = UIScreen.main.bounds.width - 30
        vHaveAdmob.lbMessage.text = message
        super.showPopUp(width: width, height: 256, type: .zoomOut)
    }
    
    func showPopUpCanPost() {
        let width = UIScreen.main.bounds.width - 30
        let attr1 = "Số tin cho phép đăng đã hết.\nVui lòng ".toAttributedString(color: AppColor.gray_65_65_65, font: vHaveAdmob.lbMessage.font, isUnderLine: false)
        
        let attr2 = "liên hệ".toAttributedString(color: AppColor.red_110_0_0, font: vHaveAdmob.lbMessage.font, isUnderLine: false)
        
        let attr3 = " với chúng tôi để được hỗ trợ!".toAttributedString(color: AppColor.gray_65_65_65, font: vHaveAdmob.lbMessage.font, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        vHaveAdmob.lbMessage.attributedText = attr
        super.showPopUp(width: width, height: 256, type: .zoomOut)
    }

//    func admobNativeView(_ admobNativeView: AdmobNativeView) {
//        hidePopUp()
//    }

    func showPopUp(message: String, closeCompletion: @escaping CompletionClosure) {
        self.completionClose = closeCompletion
        self.showPopUp(message: message)
    }
    
    
    override func btnCloseTapped() {
        super.btnCloseTapped()
        completionClose?()
    }
}
