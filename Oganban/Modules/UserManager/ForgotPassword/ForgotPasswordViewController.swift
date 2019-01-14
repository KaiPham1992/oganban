//
//  ForgotPasswordViewController.swift
//  Oganban
//
//  Created Coby on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var tfEmail: OganbanCustomTextfield!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lbNotice: UILabel!
    
	var presenter: ForgotPasswordPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        addBackToNavigation()
        setupView()
        setTitleNavigation(title: "Quên mật khẩu")
    }
    
    func setupView() {
        tfEmail.setupLayoutTextfield(placeholderText: "", titleText: "Email *", backgroundColor: AppColor.white, titleColor: AppColor.textLabel, placeholderColor: AppColor.gray, contentColor: AppColor.black, isHiddenBottomLine: false)
        btnSend.setBorderWithCornerRadius(borderWidth: 0, borderColor: AppColor.white, cornerRadius: 20)
        lbNotice.text = ""
    }

    @IBAction func  btnSendTapped() {
        let email = tfEmail.tfContent.text!
        
        if email.isValidEmail() {
            lbNotice.text = ""
            presenter?.forgotPassword(email: email)
        } else if email.isEmptyIgnoreNewLine() {
            lbNotice.text = MessageString.messageEmptyEmail
        } else {
            lbNotice.text = MessageString.messageInvalidEmailFormat
        }
    }
    
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    func didForgotPassword(data: BaseResponse?) {
        PopUpHelper.shared.showMessageHaveAds(message: "Đã Email thành công !")
        self.navigationController?.popViewController(animated: true)
    }
    
    func didForgotPassword(error: APIError?) {
//        guard let error = error?.code else { return }
//        if error == 400 {
//            PopUpHelper.shared.showMessageHaveAds(message: MessageString.messageEmailNoHave)
//        }
        lbNotice.text = MessageString.messageEmailNoHave
    }
}
