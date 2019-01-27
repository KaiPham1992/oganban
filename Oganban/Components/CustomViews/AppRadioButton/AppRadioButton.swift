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
        lb.font = AppFont.fontRegular15
        
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
    
    func setOneImage(image: UIImage) {
        self.imgUnCheck = image
        self.imgCheck = image
        self.imgIcon.image = image
    }
    
    func setTwoImage(imgCheck: UIImage, imgUnCheck: UIImage) {
        self.imgUnCheck = imgUnCheck
        self.imgCheck = imgCheck
        self.imgIcon.image = imgUnCheck
    }
}


extension AppRadioButton {
    func setMoney(money: Double) {
        let attr = NSMutableAttributedString()
        let attr1 = "Tiền mặt: ".toAttributedString(color: AppColor.red_210_2_2, font: AppFont.fontRegular13, isUnderLine: false)
        let attr2 = "\(money.toUInt64().toCurrency) ".toAttributedString(color: AppColor.red_210_2_2, font: AppFont.fontBold13, isUnderLine: false)
        attr.append(attr1)
        attr.append(attr2)
        self.lbTitle.attributedText = attr
    }
    
    func setTotalMoney(money: Double) {
        let attr = NSMutableAttributedString()
        let attr1 = "Tổng tiền: ".toAttributedString(color: AppColor.red_110_0_0, font: AppFont.fontRegular13, isUnderLine: false)
        let attr2 = "\(money.toUInt64().toCurrency) ".toAttributedString(color: AppColor.red_110_0_0, font: AppFont.fontBold13, isUnderLine: false)
        attr.append(attr1)
        attr.append(attr2)
        self.lbTitle.attributedText = attr
    }
    
    func setOCoin(coin: Double?) {
        guard let _coin = coin else { return }
        let attr = NSMutableAttributedString()
        let attr1 = "Đổi Ơcoin: ".toAttributedString(color: AppColor.green, font: AppFont.fontRegular13, isUnderLine: false)
        let attr2 = "\(_coin.toCurrency&)".toAttributedString(color: AppColor.green, font: AppFont.fontBold13, isUnderLine: false)
        let attr3 = " ơ".toAttributedString(color: AppColor.green, font: AppFont.fontBold13, isUnderLine: true)
        
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        self.lbTitle.attributedText = attr
    }
    
    func setTotalOCoin(coin: Double?) {
        guard let _coin = coin else { return }
        let attr = NSMutableAttributedString()
        let attr1 = "Tổng Ơcoin: ".toAttributedString(color: AppColor.green, font: AppFont.fontRegular13, isUnderLine: false)
        let attr2 = "\(_coin.toCurrency&)".toAttributedString(color: AppColor.green, font: AppFont.fontBold13, isUnderLine: false)
        let attr3 = " ơ".toAttributedString(color: AppColor.green, font: AppFont.fontBold13, isUnderLine: true)
        
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        self.lbTitle.attributedText = attr
    }
}
