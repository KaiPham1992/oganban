//
//  UpdateProfileViewController.swift
//  Oganban
//
//  Created Kent on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import GoogleMaps
import GooglePlaces
import FBSDKLoginKit
import FBSDKCoreKit
import ZaloSDK

class UpdateProfileViewController: BaseViewController {
    
    var presenter: UpdateProfilePresenterProtocol?
    
    @IBOutlet weak var tvCodeIntro: UITextView!
    @IBOutlet weak var lbRateCount: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbPro: UILabel!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnSave: OganbanCustomButton!
    @IBOutlet weak var tfAddress2: OganbanCustomTextfield!
    @IBOutlet weak var tfAddress1: OganbanCustomTextfield!
    @IBOutlet weak var tvPhone: PhoneNumber!
    @IBOutlet weak var tfGender: OganbanCustomTextfield!
    @IBOutlet weak var tfBirthday: OganbanCustomTextfield!
    @IBOutlet weak var tfDisplayName: OganbanCustomTextfield!
    @IBOutlet weak var tfUsername: OganbanCustomTextfield!
    
    @IBOutlet weak var tfZalo: OganbanCustomTextfield!
    @IBOutlet weak var tfFacebook: OganbanCustomTextfield!
    
    @IBOutlet weak var vCheckPhone: CheckedView!
    @IBOutlet weak var vCheckZalo: CheckedView!
    @IBOutlet weak var vCheckFacebook: CheckedView!
    
    var textFiledSelected: UITextField?
    
    var locationAddress1: CLLocationCoordinate2D?
    var locationAddress2: CLLocationCoordinate2D?
    
    var birthDay: Date? = nil
    var gender: Gender? = nil
    var countryPhoneCode: CountryCodeEntity = {
        return CountryCodeEntity(name: "Vietnam", dialCode: "+84", code: "VN")
    } ()
    
    var user: UserEntity?
    var fbAccountKit: FBAccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tapSaveButton()
        textFieldDidBeginEditing()
        hideError()
        addGesture()
        //        setDefaultData()
        presenter?.getProfileUser()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideTabbar()
        self.fbAccountKit = FBAccountKit(_controller: self)
        super.viewWillAppear(animated)
        if fbAccountKit.isLogged {
            DispatchQueue.main.async(execute: {
                self.fbAccountKit.getCountryCodeAndPhoneNumber(completion: { phone in
                    guard let _user = self.user, let _ = phone, let phoneCode = _user.phoneCode, let birthDay = _user.birthday, let fullName = _user.fullName,
                        let linkZalo = self.tfZalo.tfContent.text,
                        let linkFacebook = self.tfFacebook.tfContent.text else { return }
                    guard let _phone = phone as? PhoneEntity else { return }
                    let param = UpdateProfileParam(phoneNumber: _phone.phoneNumber&, phoneCode: _phone.phoneCode&, birthday: birthDay, fullName: fullName, gender: _user.gender, houseAddress: _user.houseAddress, companyAddress: _user.companyAddress, lat1: _user.latAddress1, long1: _user.longAddress1, lat2: _user.latAddress2, long2: _user.longAddress2, isActivePhone: self.vCheckPhone.setCheckedShowPhone(isChecked: self.vCheckPhone.isChecked), isActiveZalo: self.vCheckZalo.setCheckedShowPhone(isChecked: self.vCheckZalo.isChecked), isActiveFacebook: self.vCheckFacebook.setCheckedShowPhone(isChecked: self.vCheckFacebook.isChecked), linkZalo: linkZalo, linkFacebook: linkFacebook)
                    self.presenter?.updateProfile(userInfo: param)
                })
            })
        }
    }
    
    @IBAction func btnAvatarTapped() {
        //        let popUp = SelectPhotoCanCropPopUp()
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _iamge = image else { return }
            self.imgAvatar.image = _iamge
            self.presenter?.updateAvatar(image: _iamge)
        }
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
    
    func setDefaultData(){
        if let user = self.user {
            if let countRating = user.countRating, countRating != "" {
                lbRateCount.text = countRating + " đánh giá"
            } else {
                lbRateCount.text = "0 đánh giá"
            }
            
            if let pointRatingAvg = user.pointRatingAvg, let pointRating = Float(pointRatingAvg) {
                lbRating.text =  String(format: "%.1f", pointRating)
            } else {
                lbRating.text =  String(format: "%.1f", 0)
            }
            
            imgAvatar.sd_setImage(with: user.urlAvatar , placeholderImage: AppImage.imgDefaultUser)
            
            
            
            if let email = user.email {
                tfUsername.tfContent.text = email
            }
            
            if user.codeIntro != nil {
                tvCodeIntro.text = user.codeIntro
            }
            if user.level != nil {
                self.lbLevel.text = user.level
                if user.isPro == "1" {
                    self.lbPro.isHidden = false
                    self.lbPro.text = "  Pro"
                } else {
                    self.lbPro.isHidden = true
                    self.lbPro.text = ""
                }
                
            }
            
            if let fullName = user.fullName {
                tfDisplayName.tfContent.text = fullName
            }
            
            if let houseAddress = user.houseAddress {
                tfAddress1.tfContent.text = houseAddress
            }
            if let companyAddress = user.companyAddress {
                tfAddress2.tfContent.text = companyAddress
            }
            
            if let phone = user.phone {
                tvPhone.tfPhone.text = phone
            }
            
            if let dialCode = user.phoneCode, let countryCode = getCountryCodeFromDialCode(dialCode: dialCode) {
                self.countryPhoneCode =  countryCode
                tvPhone.lbCountryCode.text = dialCode
            }
            
            if let _birthday = user.birthday, let birthday = getBirthday(birthDay: _birthday) {
                tfBirthday.tfContent.text = birthday.toString(dateFormat: AppDateFormat.ddMMYYYY_VN)
                self.birthDay = birthday
            }
            
            if let gender = user.gender {
                tfGender.tfContent.text = convertGenderTitle(gender: gender)
                self.gender = convertStringToGender(title: gender)
            }
            
            if let linkZalo = user.linkZalo {
                self.tfZalo.tfContent.text = linkZalo
            }
            
            if let linkFacebook = user.linkFacebook {
                self.tfFacebook.tfContent.text = linkFacebook
            }
            
            vCheckPhone.setShowChecked(checked: user.isActivePhoneChecked())
            vCheckZalo.setShowChecked(checked: user.isActiveZaloChecked())
            vCheckFacebook.setShowChecked(checked: user.isActiveFacebookChecked())
            self.user = user
        }
    }
    
    func convertGenderTitle(gender: String) -> String {
        if gender == "male" {
            return "Nam"
        } else if gender == "female" {
            return "Nữ"
        } else if gender == "other" {
            return "Khác"
        } else {
            return "Chọn giới tính"
        }
    }
    
    func convertStringToGender(title: String) -> Gender {
        if title == "male" {
            return Gender(title: "Nam", keyParam: "male")
            
        } else if title == "female" {
            return Gender(title: "Nữ", keyParam: "female")
            
        } else if title == "other" {
            return Gender(title: "Khác", keyParam: "other")
        } else {
            return Gender(title: "Chọn giới tính", keyParam: nil)
        }
    }
    
    func getDialCodeFromCodePhone(code: String) -> String{
        for item in tvPhone.listCode {
            if item.code == code {
                return item.dialCode ?? ""
            }
        }
        return ""
    }
    
    func getCountryCodeFromDialCode(dialCode: String) -> CountryCodeEntity? {
        for item in tvPhone.listCode {
            if let code = item.dialCode, code.range(of:dialCode) != nil {
                return item
            }
        }
        return nil
    }
    
    func getBirthday(birthDay: String?) -> Date? {
        guard let birthDay = birthDay else {
            return nil
        }
        let date = DateFormatter()
        date.dateFormat = AppDateFormat.yyyyMMdd.formatString
        let sDate = date.date(from: birthDay)
        return sDate
    }
    
    func isEnabledSaveButton(isEnabled: Bool = true) {
        self.btnSave.isEnabledButton = isEnabled
        if isEnabled {
            self.btnSave.setupLayoutButton(backgroundColor: AppColor.green005800, titleColor: AppColor.white, text: ButtonName.saveProfile)
        } else {
            self.btnSave.setupLayoutButton(backgroundColor: AppColor.greyC8C8C8, titleColor: AppColor.white, text: ButtonName.saveProfile)
        }
    }
    
    func checkHideShowSaveButton(){
        
        var isEnabled = false
        if let user = UserDefaultHelper.shared.loginUserInfo {
            if  self.tfDisplayName.tfContent.text != user.fullName
            {
                isEnabled = true
            }
            
            if let oldDate = getBirthday(birthDay: user.birthday), let newDate = tfBirthday.tfContent.text, newDate != oldDate.toString(dateFormat: AppDateFormat.ddMMYYYY_VN) {
                isEnabled = true
            }
            
            if let gender = user.gender, convertGenderTitle(gender: gender) != tfGender.tfContent.text {
                isEnabled = true
            }
            
            if let oldCode = user.phoneCode, let newCode = countryPhoneCode.dialCode, oldCode.replacingOccurrences(of: "+", with: "") != newCode.replacingOccurrences(of: "+", with: "")
            {
                isEnabled = true
            }
            
            if self.tvPhone.tfPhone.text != user.phone
            {
                isEnabled = true
            }
            
            if user.houseAddress != tfAddress1.tfContent.text {
                isEnabled = true
            }
            
            if user.companyAddress != tfAddress2.tfContent.text {
                isEnabled = true
            }
            
            if self.tfZalo.tfContent.text != user.linkZalo {
                isEnabled = true
            }
            
            if self.tfFacebook.tfContent.text != user.linkFacebook {
                isEnabled = true
            }
            
            if self.vCheckPhone.isChecked != user.isActivePhoneChecked() {
                isEnabled = true
            }
            
            if self.vCheckZalo.isChecked != user.isActiveZaloChecked() {
                isEnabled = true
            }
            
            if self.vCheckFacebook.isChecked != user.isActiveFacebookChecked() {
                isEnabled = true
            }
        }
        
        self.isEnabledSaveButton(isEnabled: isEnabled)
    }
}

extension UpdateProfileViewController {
    func validateInputData() -> Bool {
        
        guard let username = self.tfUsername.tfContent.text else {
            hideError(isHidden: false, message: MessageString.emptyUsername)
            return false
        }
        
        if username == ""  {
            hideError(isHidden: false, message: MessageString.emptyUsername)
            return false
        }
        
        //        if username.isValidEmail() == false  {
        //            hideError(isHidden: false, message: MessageString.checkedUsername)
        //            return false
        //        }
        
        guard let displayName = self.tfDisplayName.tfContent.text else {
            hideError(isHidden: false, message: MessageString.emptyDisplayName)
            return false
        }
        
        if displayName == "" {
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
        
        if vCheckPhone.isChecked == false && vCheckZalo.isChecked == false  && vCheckFacebook.isChecked == false {
            hideError(isHidden: false, message: MessageString.sellectOne)
            return false
        }
        
        if tfZalo.tfContent.text == "" && tfFacebook.tfContent.text == "" && tvPhone.tfPhone.text == "" {
            hideError(isHidden: false, message: MessageString.allNotHave)
            return false
        }
        
        
        if tvPhone.tfPhone.text == "" && vCheckPhone.isChecked == true {
            hideError(isHidden: false, message: MessageString.emptyPhone)
            return false
        }
        
        if tvPhone.tfPhone.text!.isValidPhone2() {
            hideError(isHidden: false, message: MessageString.invalidPhone)
            return false
        }
//        if let intText = Int(self.tvPhone.tfPhone.text!) {
//            if self.tvPhone.tfPhone.text?.count != 9 && vCheckPhone.isChecked == true {
//                hideError(isHidden: false, message: MessageString.invalidPhone)
//                return false
//            }
//        } else {
//            hideError(isHidden: false, message: MessageString.invalidPhone)
//            return false
//        }
        
        
        if tfZalo.tfContent.text == "" && vCheckZalo.isChecked == true {
            hideError(isHidden: false, message: MessageString.zaloNotHave)
            return false
        }
        
        if tfFacebook.tfContent.text == "" && vCheckFacebook.isChecked == true {
            hideError(isHidden: false, message: MessageString.messengerNotHave)
            return false
        }
        
        if tfAddress1.tfContent.text == "" &&  tfAddress2.tfContent.text == "" {
            hideError(isHidden: false, message: MessageString.updateAddress)
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

extension UpdateProfileViewController: PhoneNumberDelegate {
    func phoneCodeChoose(info: CountryCodeEntity) {
        self.countryPhoneCode = info
        self.checkHideShowSaveButton()
    }
}

extension UpdateProfileViewController: PositionViewControllerDelegate {
    func positionSelected(location: CLLocationCoordinate2D, address: String, distance: PositionRangeEntity?) {
        guard let textFiledSelected = textFiledSelected else { return }
        textFiledSelected.text = address
        checkHideShowSaveButton()
        switch textFiledSelected {
        case self.tfAddress1.tfContent:
            self.locationAddress1 = location
        case self.tfAddress2.tfContent:
            self.locationAddress2 = location
        default:
            break
        }
        
    }
    
    func positionSelectedCheckBox(location: CLLocationCoordinate2D, address: String, checkBox: CheckBoxTextField) {
        print("positionSelectedCheckBox: \(address)")
    }
    
    func showMap() {
        let vc = PositionViewController.initFromNib()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        self.present(controller: nav)
    }
    
}

extension UpdateProfileViewController {
    
    //    func FBlogin() {
    //        let fbLoginManager = FBSDKLoginManager()
    //        fbLoginManager.logOut()
    //
    //        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
    //            if let error = error {
    //                print("Failed to login: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let accessToken = FBSDKAccessToken.current() else {
    //                print("Failed to get access token")
    //                return
    //            }
    //            accessToken.tokenString
    //            let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, picture.width(480).height(480),birthday"], tokenString: accessToken.tokenString, version: nil, httpMethod: "GET")
    //            req?.start(completionHandler: { (connection, result, error) in
    //                if let _result = result as? [String: Any] {
    //                    let fbModel = FacebookEntity(json: _result)
    //                    self.tfFacebook.tfContent.text = fbModel.id
    //                    self.checkHideShowSaveButton()
    //                }
    //            })
    //        }
    //    }
    func loginZalo() {
        //        ZaloSDK.sharedInstance()?.setFacebookAppId("225241758398999")
        //        ZaloSDK.sharedInstance()?.authenticateZalo(with: ZAZAloSDKAuthenTypeViaZaloAppAndWebView, parentController: self, handler: { (response) in
        //            if let _ = response?.isSucess {
        //                self.tfZalo.tfContent.text = response?.userId
        //            } else {
        //                PopUpHelper.shared.showMessageHaveAds(message: "lỗi đăng nhập")
        //            }
        //        })
        
        ZaloSDK.sharedInstance()!.authenticateZalo(with: ZAZaloSDKAuthenTypeViaWebViewOnly, parentController: self
            , handler: { response in
                if let _ = response?.isSucess {
                    self.tfZalo.tfContent.text = response?.userId
                } else {
                    PopUpHelper.shared.showMessageHaveAds(message: "lỗi đăng nhập")
                }
        })
        
        
        
        print(ZaloSDK.sharedInstance()!.appId())
        
        
    }
}
