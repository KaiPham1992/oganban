//
//  AppButton.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

/***
 - change font to font APP
 **/
import UIKit

class AppButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        self.titleLabel?.font = AppFont.fontRegular15
        self.titleLabel?.textColor = AppColor.white
    }
    
    func setTitleLanguage(title: String) {
        self.setTitle(title.showLanguage, for: .normal)
    }
}
