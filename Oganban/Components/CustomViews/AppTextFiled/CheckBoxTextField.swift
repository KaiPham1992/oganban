//
//  CheckBoxTextField.swift
//  Oganban
//
//  Created by Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class CheckBoxTextField: BaseView {
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textField: UITextField = {
        let tf = MyUITextField()
        tf.font = AppFont.fontRegular15
        tf.textColor = AppColor.textTextField
        tf.backgroundColor = .clear
        tf.textColor = .black
        return tf
    }()
    
    let btnCheckBox: AppRadioButton = {
        let btn = AppRadioButton()
        btn.setTwoImage(imgCheck: AppImage.imgCheckedTerm, imgUnCheck: AppImage.imgCheckTerm)
        btn.lbTitle.textColor = AppColor.textLabel
        btn.lbTitle.font = AppFont.fontRegularRoboto12
        
        return btn
    }()
    
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textLabel
        return view
    }()
    
    override func setUpViews() {
        self.addSubview(vContent)
        vContent.addSubview(btnCheckBox)
        vContent.addSubview(vLine)
        vContent.addSubview(textField)
        
        vContent.fillSuperview()
        btnCheckBox.anchor(vContent.topAnchor,
                       left         : vContent.leftAnchor,
                       right        : vContent.rightAnchor,
                       topConstant  : 0,
                       leftConstant : 0,
                       rightConstant: 0,
                       heightConstant: 20)
        textField.anchor(btnCheckBox.bottomAnchor, left: btnCheckBox.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        vLine.anchor(left           : vContent.leftAnchor,
                     bottom         : vContent.bottomAnchor,
                     right          : vContent.rightAnchor,
                     leftConstant   : 0,
                     bottomConstant : 0,
                     rightConstant  : 0,
                     heightConstant : 1)
        textField.delegate = self
    }
    
    func setTitleTextField(text: String) {
        btnCheckBox.setTitle(title: text)
    }
    
    func setPlaceholder(placeHolder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: AppColor.gray_65_65_65])
    }
    
    func setTextField(title: String, placeHolder: String) {
        btnCheckBox.setTitle(title: title)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: AppColor.gray_65_65_65])
    }
}

extension CheckBoxTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vLine.backgroundColor = UIColor.red
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vLine.backgroundColor = AppColor.textLabel
    }
}
