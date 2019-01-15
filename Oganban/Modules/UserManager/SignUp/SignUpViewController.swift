//
//  SignUpViewController.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

protocol SignUpViewControllerDelegate: class {
    func didSignUpSuccess()
}

class SignUpViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var vLoginName       : FTextField!
    @IBOutlet weak var vLoginEmail      : FTextField!
    @IBOutlet weak var vLoginDisplay    : FTextField!
    @IBOutlet weak var vBirthday        : FTextFieldChoose!
    @IBOutlet weak var vGender          : FTextFieldChoose!
    @IBOutlet weak var vHouseAddress    : FTextField!
    @IBOutlet weak var vCompanyAddress  : FTextField!
    @IBOutlet weak var vIntroduce       : FTextField!
    @IBOutlet weak var vPassword        : FTextField!
    @IBOutlet weak var vPasswordReType  : FTextField!
    @IBOutlet weak var vCaptcha         : FTextField!
    @IBOutlet weak var btnTermOfPolicy  : UIButton!
    @IBOutlet weak var lbStatus         : UILabel!
    @IBOutlet weak var imgCaptcha       : UIImageView!
    @IBOutlet weak var btnCheckTermOfPolicy: UIButton!
    @IBOutlet weak var vContainer       : UIView!
    
    var presenter: SignUpPresenterProtocol?
    let popUpDate = PopUpSelectDate()
    let popUpGender = PopUpSelectGender()
    var termPolicy = false
    
    
    var user: UserEntity?
    var fbAccountKit: FBAccountKit!
    let limitPhone = 15
    let limitName = 45
    
    var dateSelected: Date?
    
    weak var delegate: SignUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getCaptcha()
        fbAccountKit = FBAccountKit(_controller: self)
        
        vContainer.setShadow(color: AppColor.black.withAlphaComponent(0.7), offSet: CGSize(width: -2, height: 2))
        vContainer.setBorderWithCornerRadius(borderWidth: 0.5, borderColor: AppColor.black.withAlphaComponent(0.5), cornerRadius: 5)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fbAccountKit.isLogged {
            DispatchQueue.main.async(execute: {
                self.fbAccountKit.getCountryCodeAndPhoneNumber(completion: { phone in
                    guard let _phone = phone as? PhoneEntity, let verifyCode = self.user?.codeVerify else { return }
                    self.presenter?.verifyPhone(verifyCode: verifyCode, phoneCode: _phone.phoneCode&, phoneNum: _phone.phoneNumber&)
                    
                })
            })
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setRedStatusBar()
    }
    
    override func setUpViews() {
        vLoginName.setTextField(title: TitleString.loginName, placeHolder: TitleString.placeHolderLoginName)
        vLoginEmail.setTextField(title: TitleString.email, placeHolder: TitleString.placeHolderEmail)
        vLoginDisplay.setTextField(title: TitleString.displayName, placeHolder: TitleString.placeHolderDisplayName)
        vBirthday.setTextField(title: TitleString.birthday, placeHolder: TitleString.placeHolderBirthday)
        vGender.setTextField(title: TitleString.gender, placeHolder: TitleString.placeHolderGender)
        vHouseAddress.setTextField(title: TitleString.houseAddress, placeHolder: TitleString.placeHolderHouseAddress)
        vCompanyAddress.setTextField(title: TitleString.companyAddress, placeHolder: TitleString.placeHolderCompanyAddress)
        vIntroduce.setTextField(title: TitleString.introduce, placeHolder: TitleString.placeHolderIntroduce)
        vPassword.setTextField(title: TitleString.password, placeHolder: TitleString.placeHolderPassword)
        vPasswordReType.setTextField(title: TitleString.confirm, placeHolder: TitleString.placeHolderConfirm)
        vCaptcha.setTextField(title: TitleString.captcha, placeHolder: TitleString.placeHolderCaptcha)
        vBirthday.delegate = self
        vGender.delegate = self
        
        btnTermOfPolicy.setTitle(text: "Đồng ý ", font: AppFont.fontRegular15, color: AppColor.textTextField, textUnderline: "Điều khoản sử dụng", fontLine: AppFont.fontRegular15, colorLine: AppColor.textTextField)
        vPassword.textField.isSecureTextEntry = true
        vPasswordReType.textField.isSecureTextEntry = true
        vCaptcha.textField.keyboardType = .phonePad
        vLoginName.textField.keyboardType = .emailAddress
        vLoginEmail.textField.keyboardType = .emailAddress
        
        vHouseAddress.textField.delegate = self
        vCompanyAddress.textField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        PositionMapsHelper.shared.showSearch(controller: self) { address in
            textField.text = address
        }
    }
    
    @IBAction func btnTermOfPolicyTapped() {
        termPolicy = !termPolicy
        btnCheckTermOfPolicy.setImage(termPolicy ? AppImage.imgCheckedTerm : AppImage.imgCheckTerm, for: .normal )
        presenter?.gotoTermOfPolicy()
    }
    
    @IBAction func btnCheckTermOfPolicyTapped() {
        termPolicy = !termPolicy
        btnCheckTermOfPolicy.setImage(termPolicy ? AppImage.imgCheckedTerm : AppImage.imgCheckTerm, for: .normal )
    }
    
    @IBAction func btnSignUpTapped() {
        view.endEditing(true)
        if Utils.isConnectedToInternet() {
            if validate() {
                let email = vLoginName.textField.text
                let birthday = dateSelected?.toString(dateFormat: AppDateFormat.yyyyMMdd)
                let password = vPassword.textField.text&.sha256()
                let captcha = vCaptcha.textField.text
                let fullName = vLoginDisplay.textField.text
                let codeIntroduce = vIntroduce.textField.text
                let gender = vGender.textField.text
                let address1 = vHouseAddress.textField.text
                let address2 = vCompanyAddress.textField.text
                let param = SignUpParam(email: email, password: password, birthday: birthday&, captcha: captcha, fullName: fullName, gender: gender, address1: address1, address2: address2, codeIntroduce: codeIntroduce)
                presenter?.signUp(param: param)
            }
        } else {
            lbStatus.text = "Vui lòng kiểm tra kết nối mạng"
        }
    }
    
    @IBAction func btnRefreshTapped() {
        presenter?.getCaptcha()
    }
    
    private func validate() -> Bool {
        
        if vLoginName.textField.text&.isEmpty && vLoginEmail.textField.text&.isEmpty
            && vPassword.textField.text&.isEmpty && vPasswordReType.textField.text&.isEmpty
            && vCaptcha.textField.text&.isEmpty && vLoginDisplay.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng  nhập đầy đủ thông tin bắt buộc"
            return false
        }
        
        if vLoginName.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng nhập email"
            return false
        }
        
        if vLoginEmail.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng nhập lại email"
            return false
        }
        
        
        if vLoginEmail.textField.text&.isValidEmail() == false || vLoginName.textField.text&.isValidEmail() == false {
            lbStatus.text = "Vui lòng nhập lại email"
            return false
        }
        
        if vLoginDisplay.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng nhập tên hiển thị"
            return false
        }
        
        if vLoginDisplay.textField.text&.hasSpecialCharacters() {
            lbStatus.text = "Vui lòng nhập lại tên"
            return false
        }
        
        if vLoginDisplay.textField.text&.count > 18 {
            lbStatus.text = "Người dùng không thể nhập hơn 18 ký tự"
            return false
        }
        
        if vPassword.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng nhập mật khẩu"
            return false
        }
        
        if vPassword.textField.text&.count < 6 {
            lbStatus.text = "Mật khẩu phải từ 6 kí tự trở lên"
            return false
        }
        
        if vPasswordReType.textField.text&.isEmpty {
            lbStatus.text = "Mật khẩu không chính xác"
            return false
        }
        
        if vPassword.textField.text != vPasswordReType.textField.text {
            lbStatus.text = "Mật khẩu không trùng khớp"
            return false
        }
        
        if vCaptcha.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng nhập mã captcha"
            return false
        }
        
        guard let _ = Int(vCaptcha.textField.text&) else {
            lbStatus.text = "Vui lòng nhập lại mã captcha"
            return false
        }
        
        if vBirthday.textField.text&.isEmpty {
            lbStatus.text = "Vui lòng nhập ngày tháng năm sinh"
            return false
        }
        
        if termPolicy == false {
            lbStatus.text = "Vui lòng đồng ý điều khoản sử dụng"
            return false
        }
        
        return true
    }
    
}

extension SignUpViewController: FTextFieldChooseDelegate {
    func btnChooseTapped(sender: FTextFieldChoose) {
        switch sender {
        case vBirthday:
            popUpDate.showPopUp(currentDate: nil) { (date) in
                self.dateSelected = date
                self.vBirthday.textField.text = date?.toString(dateFormat: AppDateFormat.ddMMYYYY)
            }
        case vGender:
            popUpGender.showPopUp(currentGender: nil) { (gender) in
                guard let genderString = gender as? Gender else { return }
                self.vGender.textField.text = genderString.title
            }
        default:
            break
        }
    }
}

extension SignUpViewController: SignUpViewProtocol {
    func didVerifyPhone(response: UserEntity?) {
        guard let _user = response else { return }
        UserUtils.saveUser(user: _user)
        NotificationCenter.default.post(name: AppConstant.notiReloadMoreView, object: nil)
        
        self.navigationController?.dismiss()
    }
    
    func didVerifyPhone(error: APIError?) {
        PopUpHelper.shared.showMessageHaveAds(error: error)
    }
    
    func successCaptcha(image: UIImage) {
        imgCaptcha.image = image
    }
    
    func signUpSuccess(user: UserEntity?) {
            PopUpHelper.shared.showMessageHaveAds(message: "Bạn đã đăng kí thành công với tên đăng   \(self.vLoginName.textField.text&)")
            self.user = user
            self.fbAccountKit.verifyPhone()
        
    }
    
    func signUpError(error: APIError) {
        presenter?.getCaptcha()
        switch error.message {
        case "USER_IS_EXISTED":
            lbStatus.text = "Tên đăng nhập đã tồn tại"
        case "WRONG_CAPTCHA":
            lbStatus.text = "Mã captcha không trùng khớp"
        case "EMAIL_IS_EXISTED":
            lbStatus.text = "Email đã tồn tại"
        case "CODE_INTRODUCTION_IS_NOT_EXISTED":
            lbStatus.text = "Mã giới thiệu không tồn tại"
        case "NOT_OLD_ENOUGH":
            lbStatus.text = "Bạn không đủ tuổi để đăng ký"
        default:
            break
        }
    }
    
    
}
