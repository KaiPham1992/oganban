//
//  FTextFieldChooseDate.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

protocol FTextFieldChooseDelegate: class {
    func btnChooseTapped(sender: FTextFieldChoose)
}

class FTextFieldChoose: BaseView {
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
    
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.textLabel
        lb.font = AppFont.fontRegularRoboto12
        lb.backgroundColor = .white
        return lb
    }()
    
    let imgDown: UIImageView = {
        let img = UIImageView()
        img.image = AppImage.imgDown
        return img
    }()
    
    let btnChoose: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(btnChooseTapped), for: .touchUpInside)
        return btn
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textLabel
        return view
    }()
    
    weak var delegate: FTextFieldChooseDelegate?
    
    override func setUpViews() {
        self.addSubview(vContent)
        vContent.addSubview(lbTitle)
        vContent.addSubview(vLine)
        vContent.addSubview(textField)
        vContent.addSubview(imgDown)
        vContent.addSubview(btnChoose)
        
        vContent.fillSuperview()
        lbTitle.anchor(vContent.topAnchor,
                       left         : vContent.leftAnchor,
                       right        : vContent.rightAnchor,
                       topConstant  : 0,
                       leftConstant : 0,
                       rightConstant: 0)
        textField.fillSuperview()
        
        imgDown.anchor(bottom: vContent.bottomAnchor, right: vContent.rightAnchor, bottomConstant: 5, rightConstant: 5, widthConstant: 15, heightConstant: 15)
        vLine.anchor(left           : vContent.leftAnchor,
                     bottom         : vContent.bottomAnchor,
                     right          : vContent.rightAnchor,
                     leftConstant   : 0,
                     bottomConstant : 0,
                     rightConstant  : 0,
                     heightConstant : 1)
        btnChoose.fillSuperview()
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
    
    @objc func btnChooseTapped() {
        delegate?.btnChooseTapped(sender: self)
    }
}

extension FTextFieldChoose: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vLine.backgroundColor = UIColor.red
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vLine.backgroundColor = AppColor.textLabel
    }
}

