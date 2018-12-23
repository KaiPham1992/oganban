//
//  PopUpNotificationContent.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class PopUpNotificationContent: BaseViewXib {
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    
    override func setUpViews() {
        super.setUpViews()
        btnAccept.setBorderWithCornerRadius(borderWidth: 1, borderColor: AppColor.white, cornerRadius: btnAccept.frame.height/2)
        
        lbMessage.font = AppFont.fontRegular17
        lbMessage.textColor = AppColor.white.withAlphaComponent(0.9)
        
        lbTitle.textColor = AppColor.white
        lbTitle.font = AppFont.fontBold24
    }
}
