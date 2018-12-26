//
//  LoginProtocols.swift
//  Oganban
//
//  Created Kent on 12/19/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

import GoogleSignIn

//MARK: Wireframe -
protocol LoginWireframeProtocol: class {
    func gotoSignUp()
    func gotoHome()
    func gotoForgotPassword()
    func showSupplementaryInfoPage(loginSocialParam: LoginSocialParam)
}
//MARK: Presenter -
protocol LoginPresenterProtocol: class {
    
    var interactor: LoginInteractorInputProtocol? { get set }
    func gotoSignUp()
    func gotoHome()
    func gotoForgotPassword()
    func showSupplementaryInfoPage(loginSocialParam: LoginSocialParam)
    //---
    func login(email: String, password: String)
//    func loginGmail(user: GIDGoogleUser, phone: String)
//    func loginFacebook(fbEntity: FacebookEntity, phone: String)
    func updateProfile(codeVerify: String, phoneCode: String, phoneNumber: String)
}

//MARK: Interactor -
protocol LoginInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func didLogin(user: UserEntity?)
    func didLogin(error: APIError?)
    
    func didUpdateProfile(response: BaseResponse?)
    func didUpdateProfile(error: APIError?)
}

protocol LoginInteractorInputProtocol: class {
    
    var presenter: LoginInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
    func login(email: String, password: String)
//    func loginGmail(user: GIDGoogleUser, phone: String)
//    func loginFacebook(fbEntity: FacebookEntity, phone: String)
    func updateProfile(codeVerify: String, phoneCode: String, phoneNumber: String)
}

//MARK: View -
protocol LoginViewProtocol: class {
    
    var presenter: LoginPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func didLogin(user: UserEntity?)
    func didError(error: APIError?)
    func didUpdateProfile(response: BaseResponse?)
    func didUpdateProfile(error: APIError?)
}
