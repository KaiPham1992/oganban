//
//  ChangePasswordViewController.swift
//  Oganban
//
//  Created Coby on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var tfPassword: OganbanCustomTextfield!
    @IBOutlet weak var tfNewPassword: OganbanCustomTextfield!
    @IBOutlet weak var tfConfirmNewPassword: OganbanCustomTextfield!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
	var presenter: ChangePasswordPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setupView()
    }
    
    func setNav() {
        addBackToNavigation()
    }
    
    func setupView() {
        tfPassword.setupLayoutTextfield(placeholderText: "", titleText: "Nhập mật khẩu cũ *", backgroundColor: .clear, titleColor: AppColor.textTextField, placeholderColor: .clear, contentColor: AppColor.black, isHiddenBottomLine: false)
        tfNewPassword.setupLayoutTextfield(placeholderText: "", titleText: "Nhập mật khẩu mới *", backgroundColor: .clear, titleColor: AppColor.textTextField, placeholderColor: .clear, contentColor: AppColor.black, isHiddenBottomLine: false)
        tfConfirmNewPassword.setupLayoutTextfield(placeholderText: "", titleText: "Nhập lại mật khẩu mới *", backgroundColor: .clear, titleColor: AppColor.textTextField, placeholderColor: .clear, contentColor: AppColor.black, isHiddenBottomLine: false)
        tfPassword.showRightIcon(isHidden: false, sỉze: CGSize(width: 15, height: 15), icon: AppImage.imgOpenEye, paddingRight: 0)
        tfNewPassword.showRightIcon(isHidden: false, sỉze: CGSize(width: 15, height: 15), icon: AppImage.imgOpenEye, paddingRight: 0)
        tfConfirmNewPassword.showRightIcon(isHidden: false, sỉze: CGSize(width: 15, height: 15), icon: AppImage.imgOpenEye, paddingRight: 0)
        btnSave.setBorderWithCornerRadius(cornerRadius: 20)
        lbStatus.text = ""
        
        setActionHidePassword()
       
    }
    
    func setActionHidePassword() {
        hidePassword(isHidden: true)
        self.tfPassword.completeTapRightIcon = { (success) in
            self.view.endEditing(true)
            self.hidePassword(isHidden: success)
        }
        self.tfNewPassword.completeTapRightIcon = { (success) in
            self.view.endEditing(true)
            self.hidePassword(isHidden: success)
        }
        self.tfConfirmNewPassword.completeTapRightIcon = { (success) in
            self.view.endEditing(true)
            self.hidePassword(isHidden: success)
        }
    }
    
    func hidePassword(isHidden: Bool){
        self.tfPassword.tfContent.isSecureTextEntry = isHidden
        self.tfNewPassword.tfContent.isSecureTextEntry = isHidden
        self.tfConfirmNewPassword.tfContent.isSecureTextEntry = isHidden
        if isHidden {
            self.tfPassword.showRightIcon(isHidden: false, icon: AppImage.imgOpenEye)
            self.tfNewPassword.showRightIcon(isHidden: false, icon: AppImage.imgOpenEye)
            self.tfConfirmNewPassword.showRightIcon(isHidden: false, icon: AppImage.imgOpenEye)
        } else{
            self.tfPassword.showRightIcon(isHidden: false, icon: AppImage.imgHideEye)
            self.tfNewPassword.showRightIcon(isHidden: false, icon: AppImage.imgHideEye)
            self.tfConfirmNewPassword.showRightIcon(isHidden: false, icon: AppImage.imgHideEye)
        }
    }

    @IBAction func btnSaveTapped() {
            let password = tfPassword.tfContent.text&
            let newPassword = tfNewPassword.tfContent.text&
            let confirmPassword = tfConfirmNewPassword.tfContent.text&
        if password.isEmptyIgnoreNewLine() || newPassword.isEmptyIgnoreNewLine() || confirmPassword.isEmptyIgnoreNewLine() {
            return lbStatus.text = MessageString.invalidInput
        }
        if newPassword.count < 6 {
            return lbStatus.text = MessageString.limitCount
        }
        if confirmPassword != newPassword {
            return lbStatus.text = MessageString.invalidConfirmPassword
        }
        
        presenter?.changePassword(password: password.sha256(), newPassword: newPassword.sha256())
    }
}

extension ChangePasswordViewController: ChangePasswordViewProtocol {
    func didChangePassword(data: BaseResponseString?) {
        lbStatus.text = ""
        PopUpHelper.shared.showMessageHaveAds(message: "Đổi mật khẩu thành công")
    }
    
    func didChangePassword(error: APIError?) {
        guard let messageError = error?.message else { return }
        if messageError == "INVALID_CURRENT_PASSWORD" {
            lbStatus.text = MessageString.invalidCurentPassword
        }
    }
    
}
