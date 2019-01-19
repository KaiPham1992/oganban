//
//  CheckBoxTextField.swift
//  Oganban
//
//  Created by Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

protocol CheckBoxTextFieldDelegate: class {
    func checkBoxTextField(checkBoxTextField: CheckBoxTextField, isChecked: Bool)
    func checkBoxTextField(didEndEditting checkBoxTextField: CheckBoxTextField)
}

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
        btn.setTwoImage(imgCheck: AppImage.imgChecked, imgUnCheck: AppImage.imgUnCheck)
        btn.lbTitle.textColor = AppColor.textLabel
        btn.lbTitle.font = AppFont.fontRegularRoboto12
        
        return btn
    }()
    
    let lbUint: UILabel = {
       let lb = UILabel()
        lb.textColor = AppColor.gray_65_65_65
        
        return lb
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textLabel
        return view
    }()
    
    var isCheck: Bool {
        
        set (newValue) {
            if isCheck {
                textField.isEnabled = true
            }
            isCheck = newValue
        }
        get {
            return btnCheckBox.isChecked
        }
        
    }
    
    let lbType: UILabel = {
        let lb = UILabel()
        lb.font = AppFont.fontRegularRoboto15
        lb.text = ""
        lb.textColor = AppColor.gray_65_65_65
        return lb
    }()
    
    weak var delegate: CheckBoxTextFieldDelegate?
    
    override func setUpViews() {
        self.addSubview(vContent)
        vContent.addSubview(btnCheckBox)
        vContent.addSubview(vLine)
        vContent.addSubview(textField)
        vContent.addSubview(lbUint)
        vContent.addSubview(lbType)
        
        vContent.fillSuperview()
        btnCheckBox.anchor(vContent.topAnchor,
                           left         : vContent.leftAnchor,
                           right        : vContent.rightAnchor,
                           topConstant  : 0,
                           leftConstant : 0,
                           rightConstant: 0,
                           heightConstant: 20)
        textField.anchor(btnCheckBox.bottomAnchor, left: btnCheckBox.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 30)
        
        vLine.anchor(left           : vContent.leftAnchor,
                     bottom         : vContent.bottomAnchor,
                     right          : vContent.rightAnchor,
                     leftConstant   : 0,
                     bottomConstant : 0,
                     rightConstant  : 0,
                     heightConstant : 1)
        lbUint.anchor(right: vContent.rightAnchor, rightConstant: 5, heightConstant: 20)
        lbUint.centerToView(view: textField)
        
        lbType.anchor(right: vLine.rightAnchor, rightConstant: 0)
        lbType.centerYToView(view: textField)
        
        textField.delegate = self
        btnCheckBox.delegate = self
    }
    
    func setUint(unit: String) {
        self.lbUint.attributedText = "\(unit)".toAttributedString(color: self.lbUint.textColor, font: self.lbUint.font, isUnderLine: true)
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

extension CheckBoxTextField: UITextFieldDelegate,  AppRadioButtonDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vLine.backgroundColor = UIColor.red
        delegate?.checkBoxTextField(didEndEditting: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vLine.backgroundColor = AppColor.textLabel
    }
    
    func changedSelected(sender: AppRadioButton, isSelected: Bool) {
        delegate?.checkBoxTextField(checkBoxTextField: self, isChecked: isSelected)
    }
}
