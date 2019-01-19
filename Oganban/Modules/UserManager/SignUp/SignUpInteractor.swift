//
//  SignUpInteractor.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpInteractor: SignUpInteractorInputProtocol {
    func verifyPhone(verifyCode: String, phoneCode: String, phoneNum: String) {
        Provider.shared.userAPIService.verifyPhone(code: verifyCode, phone: phoneNum, phonCode: phoneCode, success: { user in
            guard let _user = user else { return }
            UserUtils.saveUser(user: _user)
            AppRouter.shared.openTabbar()
        }) { (error) in
            self.presenter?.didVerifyPhone(error: error)
        }
    }

    weak var presenter: SignUpInteractorOutputProtocol?
    
    func getCaptcha() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.getCaptcha(success: {(result) in
            ProgressView.shared.hide()
            guard let result = result, let imageStr = result.data as? String, let image = imageStr.toUIImage() else { return }
            self.presenter?.successCaptcha(image: image)
        }) { (error) in
            ProgressView.shared.hide()
            print("error")
        }
    }
    
    func signUp(param: SignUpParam) {
        ProgressView.shared.show()
        Provider.shared.userAPIService.signUp(param: param, success: { (user) in
            ProgressView.shared.hide()
            guard let user = user else { return}
//            UserUtils.saveLogin(user: user)
            self.presenter?.signUpSuccess(user: user)
        }) { (error) in
            ProgressView.shared.hide()
            guard let error = error else { return }
            self.presenter?.signUpError(error: error)
        }
    }
}
