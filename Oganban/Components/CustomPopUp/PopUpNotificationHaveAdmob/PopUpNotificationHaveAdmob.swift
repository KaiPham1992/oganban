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
        return v
    }()
    
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
}
