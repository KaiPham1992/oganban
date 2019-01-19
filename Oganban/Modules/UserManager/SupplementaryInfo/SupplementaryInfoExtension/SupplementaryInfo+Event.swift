//
//  SupplementaryInfo+Event.swift
//  Oganban
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit


extension SupplementaryInfoViewController {
    func textFieldDidBeginEditing() {
        tfName.textFieldDidBeginEditing = {
            self.hideError()
        }
    }
}

extension SupplementaryInfoViewController {
    func tapSendButton(){
        btnSend.tapButton = {
            self.view.endEditing(true)
            if self.validateInputData() {
                let newParam = UpdateProfileSocial(fullName: self.tfName.tfContent.text&, birthDay: self.tfBirthday.tfContent.text&, gender: self.gender?.keyParam&, address1: self.tfAddress1.tfContent.text, address2: self.tfAddress2.tfContent.text, codeIntroduction: self.tfCode.tfContent.text)
                
                self.presenter?.updateLoginSocial(socialParam: newParam)
                
            } else {
                print("Login Error")
            }
        }
    }
    
    @IBAction func tapCheckButton(_ sender: UIButton) {
        self.isCheck = !self.isCheck
    }
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        self.dismiss()
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
                self.tfSex.tfContent.text = sex.title
            }
        }
    }
    
    @objc func tapPolicyText(_ sender: UITapGestureRecognizer) {
        
        let senderView = sender.view
        if !(senderView is UITextView) {
            return
        }
        let textView: UITextView = sender.view as! UITextView
        let layoutManager = textView.layoutManager
        var location = sender.location(in: textView)
        location.x = location.x - textView.textContainerInset.left
        location.y = location.y - textView.textContainerInset.top
        
        // find the value
        let textContainer = textView.textContainer
        let characterIndex = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        let textStorage: NSTextStorage = textView.textStorage
        if (characterIndex < textStorage.length - 1) {
            var range0 = NSRange()
            
            let termsConditionsValue = textStorage.attribute( NSAttributedString.Key(rawValue: termsConditionsTag), at: characterIndex, effectiveRange: &range0)
            
            if ((termsConditionsValue) != nil) {
                print("click Điều khoản sử dụng")
                presenter?.showPolicy()
            }
            
        }
    }
}
