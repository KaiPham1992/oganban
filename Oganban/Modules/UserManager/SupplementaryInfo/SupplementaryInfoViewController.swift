//
//  SupplementaryInfoViewController.swift
//  Oganban
//
//  Created Kent on 12/20/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit


class SupplementaryInfoViewController: BaseViewController, UITextFieldDelegate {

	var presenter: SupplementaryInfoPresenterProtocol?

    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var btnSend: OganbanCustomButton!
    @IBOutlet weak var tvPolicy: UITextView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var tfCode: OganbanCustomTextfield!
    @IBOutlet weak var tfAddress2: OganbanCustomTextfield!
    @IBOutlet weak var tfAddress1: OganbanCustomTextfield!
    @IBOutlet weak var tfSex: OganbanCustomTextfield!
    @IBOutlet weak var tfBirthday: OganbanCustomTextfield!
    @IBOutlet weak var tfName: OganbanCustomTextfield!
    @IBOutlet weak var vContent: UIView!
    
    var isCheck: Bool = false {
        didSet{
            if isCheck {
                self.btnCheck.setImage(AppImage.imgCheckedTerm, for: .normal)
            }else {
                self.btnCheck.setImage(AppImage.imgCheckTerm, for: .normal)
            }
        }
    }
    
    var birthDay: Date? = nil
    var gender: Gender? = nil
    
    let textContent = "Đồng ý Điều khoản sử dụng"
    let termsConditionsString = "Điều khoản sử dụng"
    let termsConditionsTag = "TermsConditionsTag"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigation()
        hideError()
        setupView()
        setupPolicyText()
        addGesture()
        tapSendButton()
        textFieldDidBeginEditing()
        
        tfAddress1.tfContent.delegate = self
        tfAddress2.tfContent.delegate = self
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        PositionMapsHelper.shared.showSearch(controller: self) { address in
            textField.text = address
        }
    }
}

extension SupplementaryInfoViewController: SupplementaryInfoViewProtocol {
    func didLogin(user: UserEntity?) {
        guard let _user = user else { return }
        guard let _verifyCode = user?.codeVerify else { return }
        NotificationCenter.default.post(name: AppConstant.notiDidUpdateSocial, object: _verifyCode)
        UserUtils.saveUser(user: _user)
        self.dismiss()
    }
    
    func didLogin(error: APIError?) {
        self.lbError.text = error?.message
    }
}

extension SupplementaryInfoViewController {
    func validateInputData() -> Bool {
        
        guard let displayName = self.tfName.tfContent.text else {
            hideError(isHidden: false, message: MessageString.emptyDisplayName)
            return false
        }
        
        if displayName == ""  {
            hideError(isHidden: false, message: MessageString.emptyDisplayName)
            return false
        }
        
        if displayName.count > 18 {
            hideError(isHidden: false, message: MessageString.invalidDisplayNameLength)
            return false
        }
        
        let notDiacriticString = displayName.folding(options: .diacriticInsensitive, locale: .current)
        let notSpacingString = notDiacriticString.replacingOccurrences(of: " ", with: "")
        if notSpacingString.isValidLatterAndNumber() == false {
            hideError(isHidden: false, message: MessageString.specialCharacterDisplayName)
            return false
        }
        
        guard let birthDay =  self.birthDay else {
            hideError(isHidden: false, message: MessageString.emptyBirthday)
            return false
        }
        
        let age = calculateAge(birthday: birthDay)
        if age < 15  {
            hideError(isHidden: false, message: MessageString.checkedAge)
            return false
        }
        
        if !self.isCheck {
            hideError(isHidden: false, message: MessageString.notTickPolicy)
            return false
        }
        
        hideError()
        return true
    }
    
    func calculateAge(birthday: Date) -> Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        return ageComponents.year!
    }
}

extension SupplementaryInfoViewController {
    
    func setupPolicyText(){
        self.setPolicyContent()
        self.tvPolicy.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tvPolicy.isEditable = false
    }
    
    func setPolicyContent() {
        if let conditionsRange = textContent.range(of: termsConditionsString) {
            
            let attributed = NSMutableAttributedString(attributedString: NSAttributedString(string: textContent, attributes: [NSAttributedString.Key.font: AppFont.fontRegularRoboto15, NSAttributedString.Key.foregroundColor: AppColor.black414141]))
            
            let conditionsAttributes = NSDictionary.init(dictionary: [NSAttributedString.Key.font: AppFont.fontRegularRoboto15, NSAttributedString.Key.foregroundColor: AppColor.black414141,NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, termsConditionsTag: (true) ])
            
            
            attributed.addAttributes(conditionsAttributes as! [NSAttributedString.Key : Any] , range: textContent.nsRange(from: conditionsRange))
            
            self.tvPolicy.attributedText = attributed
            self.tvPolicy.textAlignment = .left
        }
    }
}
