//
//  SupplementaryInfo+Extension.swift
//  Oganban
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit

extension SupplementaryInfoViewController {
    func addGesture() {
        let tapBirthdayGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectBirthday(_:)))
        self.tfBirthday.addGestureRecognizer(tapBirthdayGesture)
        
        let tapSexGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectSex(_:)))
        self.tfSex.addGestureRecognizer(tapSexGesture)
        
        let tapPolicyGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapPolicyText(_:)))
        self.tvPolicy.addGestureRecognizer(tapPolicyGesture)
    }
    
    func setupView(){
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.isOpaque = false
        
        self.isCheck = false
        
        vContent.layer.cornerRadius = 10
        vContent.layer.masksToBounds = true
        
        tfName.setupLayoutTextfield(placeholderText: TitleString.placeHolderDisplayName, titleText: TitleString.displayName, placeholderColor: AppColor.black414141)
        tfCode.setupLayoutTextfield(placeholderText: TitleString.placeHolderIntroduce, titleText: TitleString.introduce, placeholderColor: AppColor.black414141)
        
        tfBirthday.setupLayoutTextfield(placeholderText: TitleString.placeHolderBirthday, titleText: TitleString.birthday, placeholderColor: AppColor.black414141)
        tfBirthday.showRightIcon(sỉze: CGSize(width: 11, height: 11), icon: AppImage.imgArrowDown)
        tfBirthday.tfContent.isEnabled = false
        
        
        tfSex.setupLayoutTextfield(placeholderText: TitleString.placeHolderGender, titleText: TitleString.gender, placeholderColor: AppColor.black414141)
        tfSex.showRightIcon(sỉze: CGSize(width: 11, height: 11), icon: AppImage.imgArrowDown)
        tfSex.tfContent.isEnabled = false
        
        
//        tfAddress1.setupLayoutTextfield(placeholderText: TitleString.placeHolderHouseAddress, titleText: TitleString.houseAddress, placeholderColor: AppColor.black414141)
//        tfAddress2.setupLayoutTextfield(placeholderText: TitleString.placeHolderCompanyAddress, titleText: TitleString.companyAddress, placeholderColor: AppColor.black414141)
        
        btnSend.setupLayoutButton(backgroundColor: AppColor.green005800, titleColor: AppColor.white, text: ButtonName.sendSupplementaryInfo)
    }
}
