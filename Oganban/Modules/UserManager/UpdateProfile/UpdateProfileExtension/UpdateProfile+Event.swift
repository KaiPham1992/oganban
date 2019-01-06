//
//  UpdateProfile+Event.swift
//  Oganban
//
//  Created by Admin on 12/24/18.
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
            if self.validateInputData() {
                guard let _ = self.tfUsername.tfContent.text,
                    let displayName = self.tfDisplayName.tfContent.text,
                    let phone =  self.tvPhone.tfPhone.text,
                    let phoneCode = self.countryPhoneCode.code?.lowercased(),
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
                
                self.user = UserEntity(displayName: displayName, phoneNumber: phone, phoneCode: phoneCode, birthday: birthDay, gender: gender, houseAddress: self.tfAddress1.tfContent.text, companyAddress: self.tfAddress2.tfContent.text)
                self.fbAccountKit.verifyPhone()
                
            } else {
                print("Update Error")
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
            }
        }
    }
}

extension UpdateProfileViewController: UpdateProfileViewProtocol{
    func didSuccessUpdateProfile(user: UserEntity?) {
        if let _ = user {
            PopUpHelper.shared.showMessageHaveAds(message: "Lưu thay đổi thành công")
        }
    }
    
    func didErrorUpdateProfile(error: APIError?) {
        if let _ = error?.message {
           //hideError(isHidden: false, message:  MessageString.invalidLoginEmailPassword)
            print ("Update profile: Something wrong")
        }
    }
}
