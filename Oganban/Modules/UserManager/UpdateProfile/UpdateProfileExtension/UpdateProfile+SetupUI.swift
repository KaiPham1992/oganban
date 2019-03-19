//
//  UpdateProfile+SetupUI.swift
//  Oganban
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces

extension UpdateProfileViewController: UITextFieldDelegate {
    
    func setupView(){
        self.setTitleNavigation(title: NavigationTitle.profileInfo)
        self.addBackToNavigation()
        
        imgAvatar.layer.cornerRadius = imgAvatar.frame.width / 2.0
        imgAvatar.layer.masksToBounds = true
        
        tvCodeIntro.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tvCodeIntro.isEditable = false
        
        tfUsername.setupLayoutTextfield(placeholderText: TitleString.placeHolderLoginName, titleText: TitleString.loginName, placeholderColor: AppColor.black414141, contentColor: AppColor.grey9E9E9E)
        tfUsername.tfContent.isEnabled = false
            
        tfDisplayName.setupLayoutTextfield(placeholderText: TitleString.placeHolderDisplayName, titleText: TitleString.displayName, placeholderColor: AppColor.black414141)
        
        tfBirthday.setupLayoutTextfield(placeholderText: TitleString.placeHolderBirthday, titleText: TitleString.birthday, placeholderColor: AppColor.black414141)
        tfBirthday.showRightIcon(sỉze: CGSize(width: 11, height: 11), icon: AppImage.imgArrowDown)
        tfBirthday.tfContent.isEnabled = false
        
        tfGender.setupLayoutTextfield(placeholderText: TitleString.placeHolderGender, titleText: TitleString.gender, placeholderColor: AppColor.black414141)
        tfGender.showRightIcon(sỉze: CGSize(width: 11, height: 11), icon: AppImage.imgArrowDown)
        tfGender.tfContent.isEnabled = false
        
        tvPhone.tfPhone.keyboardType = .numberPad
        tvPhone.delegate = self
        
        tfAddress1.setupLayoutTextfield(placeholderText: TitleString.placeHolderHouseAddress, titleText: TitleString.houseAddress, placeholderColor: AppColor.black414141)
        tfAddress2.setupLayoutTextfield(placeholderText: TitleString.placeHolderCompanyAddress, titleText: TitleString.companyAddress, placeholderColor: AppColor.black414141)
        
        self.isEnabledSaveButton(isEnabled: false)
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        tfAddress1.tfContent.delegate = self
        tfAddress2.tfContent.delegate = self
        
        vCheckZalo.delegate = self
        vCheckPhone.delegate = self
        vCheckFacebook.delegate = self
        tfZalo.setupLayoutTextfield(placeholderText: "Nhập tài khoản Zalo nếu có", titleText: "Tài khoản Zalo", placeholderColor: AppColor.black414141)
         tfFacebook.setupLayoutTextfield(placeholderText: "Nhập tài khoản Messenger nếu có", titleText: "Tài khoản Facebook Messenger", placeholderColor: AppColor.black414141)
    }
    
    func addGesture() {
        let tapBirthdayGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectBirthday(_:)))
        self.tfBirthday.addGestureRecognizer(tapBirthdayGesture)
        
        let tapSexGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectSex(_:)))
        self.tfGender.addGestureRecognizer(tapSexGesture)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.textFiledSelected = textField
        showMap()
        
        
//        PositionMapsHelper.shared.showSearchPlace(controller: self) { place in
//            guard let _place = place as? GMSPlace else { return }
//
//            switch textField {
//            case self.tfAddress1.tfContent:
//                self.tfAddress1.tfContent.text = _place.formattedAddress&
//                self.locationAddress1 = _place.coordinate
//                self.checkHideShowSaveButton()
//            case self.tfAddress2.tfContent:
//                self.tfAddress2.tfContent.text = _place.formattedAddress&
//                self.locationAddress2 = _place.coordinate
//                self.checkHideShowSaveButton()
//
//            default:
//                break
//            }
//        }
    }
}
