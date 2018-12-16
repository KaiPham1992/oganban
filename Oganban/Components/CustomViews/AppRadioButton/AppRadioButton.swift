//
//  AppRadioButton.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

protocol AppRadioButtonDelegate: class {
    func changedSelected(sender: AppRadioButton, isSelected: Bool)
}

class AppRadioButton: BaseView {

    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.white
        lb.font = AppFont.fontRegular17
        
        return lb
    }()
    
    let imgIcon: UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    let btnAction: UIButton = {
       let btn = UIButton()
        
        return btn
    }()
    
    weak var delegate: AppRadioButtonDelegate?
    var imgUnCheck = AppImage.imgUnCheck
    var imgCheck = AppImage.imgCheck
    
    var leading: NSLayoutConstraint?
    var tralling: NSLayoutConstraint?
    
    override func setUpViews() {
        super.setUpViews()
        self.backgroundColor = .clear
        addSubview(lbTitle)
        addSubview(imgIcon)
        addSubview(btnAction)
        
        //--
        imgIcon.anchor(widthConstant: 20, heightConstant: 20)
        imgIcon.centerYToSuperview()
        setContentToLeft()
        
        lbTitle.anchor( left: imgIcon.rightAnchor, leftConstant: 5)
        lbTitle.centerYToView(view: imgIcon)
        
        btnAction.fillSuperview()
        btnAction.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
        
        imgIcon.image = imgUnCheck
    }

    var isChecked: Bool = false {
        didSet {
            let img = isChecked == true ? imgCheck: imgUnCheck
            self.imgIcon.image = img
        }
    }
    
    func setContentToLeft() {
        tralling?.isActive = false
        leading = imgIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
        leading?.isActive = true
    }
    
    func setContentToRight() {
        leading?.isActive = false
        tralling = lbTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        tralling?.isActive = true
    }

    @IBAction private func btnActionTapped() {
        isChecked = !isChecked
        delegate?.changedSelected(sender: self, isSelected: self.isChecked)
    }
    
    func setTitle(title: String) {
        self.lbTitle.text = title.showLanguage
    }
}
