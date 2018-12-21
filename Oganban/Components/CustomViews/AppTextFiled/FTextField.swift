//
//  LTextField.swift
//  led-controller-ios
//
//  Created by Tien Dinh on 10/2/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit

class FTextField: BaseView {
    let vContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textField: UITextField = {
        let tf = MyUITextField()
        tf.font = AppFont.fontRegular15
        tf.backgroundColor = .clear
        tf.textColor = .black
        return tf
    }()
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.textLabel
        lb.font = AppFont.fontRegular13
        lb.backgroundColor = .white
        return lb
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textLabel
        return view
    }()
    
    override func setUpViews() {
        self.addSubview(vContent)
        vContent.addSubview(lbTitle)
        vContent.addSubview(vLine)
        vContent.addSubview(textField)
        
        vContent.fillSuperview()
        lbTitle.anchor(vContent.topAnchor,
                       left         : vContent.leftAnchor,
                       right        : vContent.rightAnchor,
                       topConstant  : 0,
                       leftConstant : 0,
                       rightConstant: 0)
        textField.fillSuperview()
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
        lbTitle.text = text
    }
    
    func setPlaceholder(placeHolder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    func setTextField(title: String, placeHolder: String) {
        lbTitle.text = title
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}

extension RTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vLine.backgroundColor = UIColor.red
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vLine.backgroundColor = AppColor.textLabel
    }
}

class MyUITextField: UITextField {
    // Whatever you like
    let padding = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0);
    // Paddging for place holder
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    // Padding for text
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    // Padding for text in editting mode
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}


