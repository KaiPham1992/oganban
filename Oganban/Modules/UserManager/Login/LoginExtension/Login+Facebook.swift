//
//  Login+Facebook.swift
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
    private enum FacebookKey: String {
        case userId = "id"
        case email = "email"
        case name = "name"
        case lastName = "last_name"
        case firstName = "first_name"
        case picture = "picture"
        case gender = "gender"
        case birthday = "birthday"
    }
    
    func FBlogin() {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = .native
        fbLoginManager.logOut()
        
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480),birthday"], tokenString: accessToken.tokenString, version: nil, httpMethod: "GET")
            req?.start(completionHandler: { (connection, result, error) in
                if let _result = result as? [String: Any] {
                    let fbModel = FacebookEntity(json: _result)
                    self.loginType = .facebook
                    self.paramLogin = fbModel
                    self.fbAccountKit.verifyPhone()
                }
            })
        }
    }
}
