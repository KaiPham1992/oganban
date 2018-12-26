//
//  LoginViewController.swift
//  Oganban
//
//  Created Kent on 12/19/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import CryptoSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration

enum LoginType {
    case gmail
    case facebook
    case normal
}

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var lbTutorial: UILabel!
    @IBOutlet weak var lbForgetPassword: UILabel!
    @IBOutlet weak var btnSignUp: OganbanCustomButton!
    @IBOutlet weak var btnGoogle: OganbanCustomButton!
    @IBOutlet weak var btnFacebook: OganbanCustomButton!
    @IBOutlet weak var btnLogin: OganbanCustomButton!
    @IBOutlet weak var tfPassword: OganbanCustomTextfield!
    @IBOutlet weak var tfEmail: OganbanCustomTextfield!
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vContent: UIView!
    
    var loginType = LoginType.normal
    var fbAccountKit: FBAccountKit!
    var paramLogin: Any?
    
    var verifyCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.addGestures()
        self.tapButtons()
        self.textFieldDidBeginEditing()
        self.addDelegate()
        self.hideError()
        self.fbAccountKit = FBAccountKit(_controller: self)
    }
    
    @IBAction func btnForgotPasswordTapped() {
        presenter?.gotoForgotPassword()
    }
}

extension LoginViewController {
    func validateInputData() -> Bool {
        
        guard let email = self.tfEmail.tfContent.text,  let password = self.tfPassword.tfContent.text else {
            hideError(isHidden: false, message: MessageString.invalidLoginEmailPassword)
            return false
        }
        if email.isValidEmail() == false {
            hideError(isHidden: false, message:  MessageString.invalidLoginEmailPassword)
            return false
        }
        if password.count < 6 {
            hideError(isHidden: false, message:  MessageString.invalidLoginEmailPassword)
            return false
        }
        hideError()
        return true
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
}




