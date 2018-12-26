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
        print("SUCCESS LOGIN")
        self.dismiss(animated: true)
    }
    
    func didError(error: APIError?) {
        if let message = error?.message {
            switch message {
            case "INVALID_USERNAME_OR_PASSWORD":
                hideError(isHidden: false, message:  MessageString.invalidLoginEmailPassword)
                break
            case "USER_IS_NOT_VERIFY":
                print(message)
                //hideError(isHidden: false, message:  MessageString.notVerifyUser)
                break
            default:
                break
            }
        }
    }
    
    func didUpdateProfile(response: BaseResponse?) {
        
    }
    
    func didUpdateProfile(error: APIError?) {
        
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
            print("TAP SIGN UP")
            
            PopUpHelper.shared.showNoGPS()
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
