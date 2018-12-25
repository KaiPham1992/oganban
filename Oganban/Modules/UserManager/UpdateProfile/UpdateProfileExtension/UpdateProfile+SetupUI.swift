//
//  UpdateProfile+SetupUI.swift
//  Oganban
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit

extension UpdateProfileViewController {
    
    func setupView(){
        self.setTitleNavigation(title: NavigationTitle.profileInfo)
        self.addBackToNavigation()
        
        imgAvatar.layer.cornerRadius = imgAvatar.frame.width / 2.0
        imgAvatar.layer.masksToBounds = true
        
        tfUsername.setupLayoutTextfield(placeholderText: TitleString.placeHolderLoginName, titleText: TitleString.loginName, placeholderColor: AppColor.black414141)
        
        tfDisplayName.setupLayoutTextfield(placeholderText: TitleString.placeHolderDisplayName, titleText: TitleString.displayName, placeholderColor: AppColor.black414141)
        
        tfBirthday.setupLayoutTextfield(placeholderText: TitleString.placeHolderBirthday, titleText: TitleString.birthday, placeholderColor: AppColor.black414141)
        tfBirthday.showRightIcon(sỉze: CGSize(width: 11, height: 11), icon: AppImage.imgArrowDown)
        tfBirthday.tfContent.isEnabled = false
        
        tfGender.setupLayoutTextfield(placeholderText: TitleString.placeHolderGender, titleText: TitleString.gender, placeholderColor: AppColor.black414141)
        tfGender.showRightIcon(sỉze: CGSize(width: 11, height: 11), icon: AppImage.imgArrowDown)
        tfGender.tfContent.isEnabled = false
        
        tvPhone.tfPhone.keyboardType = .numberPad
        
        tfAddress1.setupLayoutTextfield(placeholderText: TitleString.placeHolderHouseAddress, titleText: TitleString.houseAddress, placeholderColor: AppColor.black414141)
        tfAddress2.setupLayoutTextfield(placeholderText: TitleString.placeHolderCompanyAddress, titleText: TitleString.companyAddress, placeholderColor: AppColor.black414141)
        
        btnSave.setupLayoutButton(backgroundColor: AppColor.green005800, titleColor: AppColor.white, text: ButtonName.saveProfile)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func addGesture() {
        let tapBirthdayGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectBirthday(_:)))
        self.tfBirthday.addGestureRecognizer(tapBirthdayGesture)
        
        let tapSexGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectSex(_:)))
        self.tfGender.addGestureRecognizer(tapSexGesture)
    }
}
