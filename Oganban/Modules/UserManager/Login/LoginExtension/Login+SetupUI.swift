//
//  Login+SetupUI.swift
//  Oganban
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit

// MARK: GOOGLE
extension LoginViewController {
    
    func setupView() {
        setupContentView()
        setupButtons()
        hidePassword(isHidden: true)
    }
    
    func setupContentView() {
        
        vContent.backgroundColor = .white
        vContent.addShadow(ofColor: UIColor.black, radius: 0, offset: CGSize(width: 1, height: 1), opacity: 0.5)
        vContent.setBorderWithCornerRadius(borderWidth: 0.5, borderColor: #colorLiteral(red: 0.7370565534, green: 0.7411661744, blue: 0.7452144027, alpha: 1), cornerRadius: 10)
        
        tfEmail.setupLayoutTextfield(placeholderText: "", titleText: TitleString.loginName)
        tfPassword.setupLayoutTextfield(placeholderText: "", titleText: TitleString.password)
    }
    
    func setupButtons(){
        btnLogin.setupLayoutButton(backgroundColor: AppColor.green005800, text: ButtonName.login)
        btnFacebook.setupLayoutButton(backgroundColor: AppColor.blue3A559F, icon: AppImage.imgFb, text: ButtonName.facebook)
        btnGoogle.setupLayoutButton(backgroundColor: AppColor.redD51F1F, icon: AppImage.imgGoogle, text: ButtonName.google)
        btnSignUp.setupLayoutButton(backgroundColor: AppColor.white)
        btnSignUp.setBorderWithCornerRadius(borderWidth: 0.5, borderColor: AppColor.greyC8C8C8)
        setTitleForSignupButton()
    }
    
    func setTitleForSignupButton(){
        let attributed = NSMutableAttributedString(attributedString: NSAttributedString(string: "Chưa có Tài khoản?", attributes: [NSAttributedString.Key.font: AppFont.fontRegularRoboto15, NSAttributedString.Key.foregroundColor: AppColor.black414141]))
        
        let signupAttributes = NSAttributedString(string: " " + ButtonName.signup, attributes: [NSAttributedString.Key.font: AppFont.fontBoldRoboto15, NSAttributedString.Key.foregroundColor: AppColor.black414141])
        
        attributed.append(signupAttributes)
        btnSignUp.lbTitle.attributedText = attributed
    }
    
    func addGestures() {
        let tapForgetPasswordGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapForgetPassword(sender:)))
        lbForgetPassword.addGestureRecognizer(tapForgetPasswordGesture)
        
        let tapTutorialGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapTutorial(sender:)))
        lbTutorial.addGestureRecognizer(tapTutorialGesture)
    }
}
