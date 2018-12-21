//
//  AppTextFiled.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class AppTextField : UITextField {
    
    lazy var vLine: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        self.backgroundColor = .clear
        //add line
        self.delegate = self
        vLine.backgroundColor = AppColor.textColor
        addSubview(vLine)
        vLine.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 0, heightConstant: 1)
        self.borderStyle = .none
        
        // font style
        self.textColor = .black
        self.placeHolderColor = AppColor.white.withAlphaComponent(0.5)
        self.font = AppFont.fontRegular15
        self.attributedPlaceholder = self.placeholder&.showLanguage.toAttributedString(color: AppColor.gray, font: self.font, isUnderLine: false)
    }
    
    func setPlaceHolder(placeholder: String) {
        self.attributedPlaceholder = placeholder.showLanguage.toAttributedString(color: AppColor.gray, font: self.font, isUnderLine: false)
    }
}

extension AppTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vLine.backgroundColor = UIColor.red
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vLine.backgroundColor = AppColor.textLabel
    }
}
