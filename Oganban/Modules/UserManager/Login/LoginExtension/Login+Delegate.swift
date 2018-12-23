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
        
    }
    
    func didError(error: APIError?) {
        
    }
    
    func didUpdateProfile(response: BaseResponse?) {
        
    }
    
    func didUpdateProfile(error: APIError?) {
        
    }
}
