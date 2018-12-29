//
//  FBAccountKit.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/22/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import AccountKit

class FBAccountKit: NSObject {
    var accountKit: AKFAccountKit!
    var controller: UIViewController!
    
    init(_controller: UIViewController) {
        super.init()
        if accountKit == nil {
            accountKit = AKFAccountKit(responseType: .accessToken)
        }
        controller = _controller
    }
    
    var isLogged: Bool {
        guard  let _accountKit = accountKit else { return false }
        return _accountKit.currentAccessToken != nil
    }
    
    func verifyPhone() {
        accountKit.logOut()
        let inputState: String = UUID().uuidString
        let viewController:AKFViewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState)  as AKFViewController
        viewController.enableSendToFacebook = true
        controller.present(controller: viewController as! UIViewController)
    }
    
    func getCountryCodeAndPhoneNumber(completion: @escaping CompletionAny) {
        accountKit.requestAccount {
            (account, error) -> Void in
            guard let phoneNumber = account?.phoneNumber?.phoneNumber, let phoneCode = account?.phoneNumber?.countryCode else { return }
            let phone = PhoneEntity(phoneNumber: phoneNumber, phoneCode: phoneCode)
            self.logOut()
            completion(phone)
        }
    }
    
    func logOut() {
        accountKit.logOut()
    }
}
