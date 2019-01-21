//
//  UpdateProfile+Event.swift
//  Oganban
//
//  Created by Kent on 12/24/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit

extension UpdateProfileViewController {
    func textFieldDidBeginEditing() {
        tfUsername.textFieldDidBeginEditing = {
            self.hideError()
        }
        tfDisplayName.textFieldDidBeginEditing = {
            self.hideError()
        }
        tvPhone.textFieldDidBeginEditing = {
            self.hideError()
        }
        tfAddress1.textFieldDidBeginEditing = {
            self.hideError()
        }
        tfAddress2.textFieldDidBeginEditing = {
            self.hideError()
        }
        
        tvPhone.textFieldDidBeginEditing = {
            self.hideError()
        }
        
        tfDisplayName.textFieldDidChange = {
           self.checkHideShowSaveButton()
        }
        
        tvPhone.textFieldDidChange = {
            self.checkHideShowSaveButton()
        }
        
    }
}

extension UpdateProfileViewController {
    
    @IBAction func tapShareButton(_ sender: UIButton) {
        print("TAP SHARE BUTTON")
        if let user = UserDefaultHelper.shared.loginUserInfo, let codeIntro = user.codeIntro{
            ShareNativeHelper.shared.showShare(controller: self, items: [codeIntro])
        }
    }
    
    func tapSaveButton(){
        btnSave.tapButton = {
            self.view.endEditing(true)
            if Utils.isConnectedToInternet() {
                if self.validateInputData() {
                    guard let _ = self.tfUsername.tfContent.text,
                        let displayName = self.tfDisplayName.tfContent.text,
                        let phone =  self.tvPhone.tfPhone.text,
                        let dialCode = self.countryPhoneCode.dialCode,
                        let birthDay =  self.birthDay?.toString(dateFormat: AppDateFormat.yyyyMMdd) else {
                            return
                    }
                    
                    var gender = ""
                    if self.tfGender.tfContent.text == "Nữ" {
                        gender = "female"
                    }
                    else if self.tfGender.tfContent.text == "Nam" {
                        gender = "male"
                    }
                    else if self.tfGender.tfContent.text == "Khác" {
                        gender = "other"
                    }
                    
                    let lat1 = self.locationAddress1?.latitude.description
                    let long1 = self.locationAddress1?.longitude.description
                    let lat2 = self.locationAddress2?.latitude.description
                    let long2 = self.locationAddress2?.longitude.description
                    
                    let param = UpdateProfileParam(phoneNumber: phone, phoneCode: dialCode, birthday: birthDay, fullName: displayName, gender: gender, houseAddress: self.tfAddress1.tfContent.text, companyAddress: self.tfAddress2.tfContent.text, lat1: lat1, long1: long1, lat2: lat2, long2: long2)
                    
                    //self.user = UserEntity(displayName: displayName, phoneNumber: phone, phoneCode: dialCode, birthday: birthDay, gender: gender, houseAddress: self.tfAddress1.tfContent.text, companyAddress: self.tfAddress2.tfContent.text, lat1: lat1, long1: long1 ,lat2: lat2, long2: long2)
                    
                    if let oldUserInfo = UserDefaultHelper.shared.loginUserInfo {
                        if phone != oldUserInfo.phone || dialCode.range(of:oldUserInfo.phoneCode ?? "nil") == nil {
                            self.fbAccountKit.verifyPhone()
                        } else {
                            self.presenter?.updateProfile(userInfo: param)
                        }
                    }
                    
                }
            } else {
                self.lbError.text = "Vui lòng kiểm tra kết nối mạng"
            }
        }
    }
    
    @objc func selectBirthday(_ sender: UITapGestureRecognizer) {
        hideError()
        let popUp = PopUpSelectDate()
        popUp.vDateContent.vPickerDate.maximumDate = Date()
        popUp.showPopUp(currentDate: birthDay) { (date) in
            if let date = date {
                self.birthDay = date
                self.tfBirthday.tfContent.text =  date.toString(dateFormat: AppDateFormat.ddMMYYYY_VN)
                
                self.checkHideShowSaveButton()
            }
        }
    }
    
    @objc func selectSex(_ sender: UITapGestureRecognizer) {
        hideError()
        let popUp = PopUpSelectGender()
        popUp.showPopUp(currentGender: self.gender ) { (gender) in
            if let sex: Gender = gender as? Gender {
                self.gender = sex
                self.tfGender.tfContent.text = sex.title
                
                self.checkHideShowSaveButton()
            }
        }
    }
}

extension UpdateProfileViewController: UpdateProfileViewProtocol{
    func didSuccessUpdateProfile(user: UserEntity?) {
        if let _ = user {
            PopUpHelper.shared.showMessageHaveAds(message: "Lưu thay đổi thành công") {
                self.pop()
            }
        }
    }
    
    func didErrorUpdateProfile(error: APIError?) {
        if let _ = error?.message {
           //hideError(isHidden: false, message:  MessageString.invalidLoginEmailPassword)
            print ("Update profile: Something wrong")
        }
    }
}
