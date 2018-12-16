//
//  AppTextfiledLogin.swift
//  RedStar
//
//  Created by Coby on 11/17/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit

class AppTextfiledLogin: UIView {
    
    lazy var tfInput: UITextField = {
        let textfield = UITextField()
        
        return textfield
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var vLine: UIView = {
       let view = UIView()
        view.backgroundColor = AppColor.gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        layout()
    }
    
    private func setupView() {
        tfInput.backgroundColor = .clear
        tfInput.borderStyle = .none
        //-- add line
        
        //font style
        tfInput.textColor = .black
        tfInput.placeHolderColor = AppColor.white.withAlphaComponent(0.5)
        tfInput.font = AppFont.fontRegular15
        
        addSubview(tfInput)
        addSubview(vLine)
        addSubview(image)
    }
    
    func layout() {
        tfInput.anchor( left: image.rightAnchor, right: self.rightAnchor, leftConstant: 10, rightConstant: 0)
        tfInput.centerYToView(view: image)
        vLine.anchor( left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, leftConstant: -30, bottomConstant: 10, rightConstant: 0, heightConstant: 1)
        //---
        image.anchor( right: self.leftAnchor, rightConstant: 10, widthConstant: 21, heightConstant: 21)
        image.centerYToSuperview(constant: 0)
    }
    
    func setPlaceHolder(placeholder: String) {
        tfInput.attributedPlaceholder = placeholder.showLanguage.toAttributedString(color: AppColor.gray, font: tfInput.font, isUnderLine: false)
    }
    
    func setImage(img: UIImage?) {
        image.image = img
    }
}
