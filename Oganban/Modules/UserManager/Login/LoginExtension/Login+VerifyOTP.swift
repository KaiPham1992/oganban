//
//  LoginViewController+Verify.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

import CryptoSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration

extension LoginViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fbAccountKit.isLogged {
            DispatchQueue.main.async(execute: {
                self.fbAccountKit.getCountryCodeAndPhoneNumber(completion: { phone in
                    guard let _phone = phone as? PhoneEntity else { return }
                    
                    switch self.loginType {
                    case .gmail:
                        break
                    case .facebook:
                        break 
                    case .normal:
                        guard let _codeVerify = self.verifyCode, let phoneCode =  _phone.phoneCode, let phoneNum = _phone.phoneNumber else { return }
                        self.presenter?.updateProfile(codeVerify: _codeVerify, phoneCode: phoneCode , phoneNumber: phoneNum)
                        break
                    }
                    
                })
            })
        }
    }
}
