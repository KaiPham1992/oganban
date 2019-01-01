//
//  Login+Delegate.swift
//  Oganban
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import CryptoSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration

extension LoginViewController {
    
    func addDelegate(){
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
}

extension LoginViewController: LoginViewProtocol {
    func didLogin(user: UserEntity?) {
        guard let _user = user else { return }
        if loginType != .normal {
            if user?.isLoggedSocial == nil {
                DataManager.shared.tempToken = _user.jwt&
                self.presenter?.showSupplementaryInfoPage()
            }
            // update info and verify
            if user?.isLoggedSocial == "1" {
                if user?.isVerified == "1" {
                    UserUtils.saveUser(user: _user)
                    self.dismiss()
                } else {
                    self.verifyCode = _user.codeVerify
                    fbAccountKit.verifyPhone()
                }
            }
        } else {
            UserUtils.saveUser(user: _user)
            self.dismiss(animated: true)
        }
    }
    
    func didError(error: APIError?) {
        if let message = error?.message {
            switch message {
            case "INVALID_USERNAME_OR_PASSWORD":
                hideError(isHidden: false, message:  MessageString.invalidLoginEmailPassword)
                break
            case "USER_IS_NOT_VERIFY":
                self.verifyCode = error?.codeVerify
                fbAccountKit.verifyPhone()
                break
            case "PHONE_IS_EXISTED":
                PopUpHelper.shared.showMessageHaveAds(message: "Số điện thoại đã tồn tại")
            default:
                break
            }
        }
    
    }
}

extension LoginViewController {
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func tapForgetPassword(sender: UITapGestureRecognizer){
        print("Tap Forget Password")
    }
    
    @objc func tapTutorial(sender: UITapGestureRecognizer){
        print("Tap Tutorial")
    }
    
    func tapButtons(){
        self.btnLogin.tapButton = {
            self.view.endEditing(true)
            if self.validateInputData() {
                let email = self.tfEmail.tfContent.text ?? ""
                let password = self.tfPassword.tfContent.text&.sha256()
                self.presenter?.login(email: email, password: password)
            } else {
                print("Login: Something is wrong")
            }
        }
        
        self.btnGoogle.tapButton = {
            self.view.endEditing(true)
            GIDSignIn.sharedInstance().signOut()
            GIDSignIn.sharedInstance().signIn()
            
        }
        
        self.btnFacebook.tapButton = {
            self.view.endEditing(true)
            self.FBlogin()
        }
        
        self.btnSignUp.tapButton = {
            self.view.endEditing(true)
            self.presenter?.gotoSignUp()
        }
        
        self.tfPassword.completeTapRightIcon = { (success) in
            self.view.endEditing(true)
            self.hidePassword(isHidden: success)
        }
    }
    
    func hidePassword(isHidden: Bool){
        self.tfPassword.tfContent.isSecureTextEntry = isHidden
        if isHidden {
            self.tfPassword.showRightIcon(isHidden: false, icon: AppImage.imgOpenEye)
        } else{
            self.tfPassword.showRightIcon(isHidden: false, icon: AppImage.imgHideEye)
        }
    }
    
}
extension LoginViewController {
    func textFieldDidBeginEditing() {
        tfEmail.textFieldDidBeginEditing = {
            self.hideError()
        }
        tfPassword.textFieldDidBeginEditing = {
            self.hideError()
        }
    }
}
