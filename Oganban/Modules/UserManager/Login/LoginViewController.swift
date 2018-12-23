//
//  LoginViewController.swift
//  Oganban
//
//  Created Admin on 12/19/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
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
        self.tapButtons()
        self.textFieldDidBeginEditing()
        
        fbAccountKit = FBAccountKit(_controller: self)
    }
    
    func setupView() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        hideNavigation()
        hideError()
        vContent.backgroundColor = .white
        vContent.layer.cornerRadius = 10
        vContent.layer.masksToBounds = true
        vContent.layer.shadowColor = UIColor.black.cgColor
        vContent.layer.shadowOffset = CGSize(width: 1, height: 1)
        vContent.layer.shadowOpacity = 0.5
        vContent.layer.masksToBounds = false
        vContent.layer.borderColor = #colorLiteral(red: 0.7370565534, green: 0.7411661744, blue: 0.7452144027, alpha: 1)
        vContent.layer.borderWidth = 0.5
        
        tfEmail.setupLayoutTextfield(placeholderText: "", titleText: "Tên đăng nhập *")
        tfPassword.setupLayoutTextfield(placeholderText: "", titleText: "Mật khẩu *")
        hidePassword(isHidden: true)
        
        btnLogin.setupLayoutButton(backgroundColor: AppColor.green005800, text: "Đăng nhập")
        btnFacebook.setupLayoutButton(backgroundColor: AppColor.blue3A559F, icon: AppImage.imgFb, text: "Facebook")
        btnGoogle.setupLayoutButton(backgroundColor: AppColor.redD51F1F, icon: AppImage.imgGoogle, text: "Google")
        btnSignUp.setupLayoutButton(backgroundColor: AppColor.white)
        btnSignUp.setBorder(borderWidth: 0.5, borderColor: AppColor.greyC8C8C8)
        setTitleForSignupButton()
        
        let tapForgetPasswordGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapForgetPassword(sender:)))
        lbForgetPassword.addGestureRecognizer(tapForgetPasswordGesture)
        
        let tapTutorialGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapTutorial(sender:)))
        lbTutorial.addGestureRecognizer(tapTutorialGesture)
        
    }
    
    func setTitleForSignupButton(){
        let attributed = NSMutableAttributedString(attributedString: NSAttributedString(string: "Chưa có Tài khoản?", attributes: [NSAttributedString.Key.font: AppFont.fontRegularRoboto15, NSAttributedString.Key.foregroundColor: AppColor.black414141]))
        
        let signupAttributes = NSAttributedString(string: " Đăng ký", attributes: [NSAttributedString.Key.font: AppFont.fontBoldRoboto15, NSAttributedString.Key.foregroundColor: AppColor.black414141])
        
        attributed.append(signupAttributes)
        btnSignUp.lbTitle.attributedText = attributed
    }
    
    func validateInputData() -> Bool {
       
        guard let email = self.tfEmail.tfContent.text,  let password = self.tfPassword.tfContent.text else {
            hideError(isHidden: false, message: "Vui lòng kiểm tra lại email hoặc mật khẩu")
            return false
        }
        if email.isValidEmail() == false {
            hideError(isHidden: false, message: "Vui lòng kiểm tra lại email hoặc mật khẩu")
            return false
        }
        if password.count < 6 {
            hideError(isHidden: false, message: "Vui lòng kiểm tra lại email hoặc mật khẩu")
            return false
        }
        hideError()
        return true
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true)
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
    
    func tapButtons(){
        self.btnLogin.tapButton = {
            self.view.endEditing(true)
            if self.validateInputData() {
                let vc = SupplementaryInfoRouter.createModule()
                vc.modalPresentationStyle = .overFullScreen
                self.present(controller: vc, animated: true)
                print("Success")
            } else {
                print("Login Error")
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
    
    @objc func tapForgetPassword(sender: UITapGestureRecognizer){
        print("Tap Forget Password")
    }
    
    @objc func tapTutorial(sender: UITapGestureRecognizer){
        print("Tap Tutorial")
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