//
//  PostStepTwoViewController.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import GoogleMaps
import GooglePlaces



class PostStepTwoViewController: BaseViewController {
    
    var presenter: PostStepTwoPresenterProtocol?
    @IBOutlet weak var vAddress1: CheckBoxTextField!
    @IBOutlet weak var vAddress2: CheckBoxTextField!
    @IBOutlet weak var vCheckGPS: AppRadioButton!
    
    @IBOutlet weak var vMoney: CheckBoxTextField!
    @IBOutlet weak var vCoin: CheckBoxTextField!
    @IBOutlet weak var lbNotice: UILabel!
    @IBOutlet weak var lbPayType: UILabel!
    
    var param = PostRecordParam()
    var errorMessage: String = ""
    
    var locationAddress1: CLLocationCoordinate2D?
    var locationAddress2: CLLocationCoordinate2D?
    
    var record: RecordEntity?
    var isCopyUpdate: Bool = false
    var isService: Bool = false
    var isGPSCurrent: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setUpViews() {
        super.setUpViews()
        lbPayType.text = isService ? "Phương thức thanh toán" : "Phương thức thanh toán*"
        vAddress1.setTextField(title: "Địa chỉ 1", placeHolder: "Bạn có thể nhập địa chỉ nhà")
        vAddress1.btnCheckBox.lbTitle.textColor = AppColor.gray_65_65_65
        vAddress2.btnCheckBox.lbTitle.textColor = AppColor.gray_65_65_65
        vAddress2.setTextField(title: "Địa chỉ 2", placeHolder: "Bạn có thể nhập địa chỉ công ty")
        vCheckGPS.setTwoImage(imgCheck: AppImage.imgChecked, imgUnCheck: AppImage.imgUnCheck)
        vCheckGPS.setTitle(title: "Vị trí GPS thực tế")
        vCheckGPS.lbTitle.textColor = AppColor.gray_65_65_65
        
        vMoney.setTextField(title: "Tiền mặt", placeHolder: "Nhập số tiền sẽ bán")
        vMoney.btnCheckBox.lbTitle.textColor = AppColor.gray_65_65_65
        vMoney.textField.keyboardType = UIKeyboardType.numberPad
        vMoney.textField.textColor = .gray
        vMoney.textField.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingChanged)
//        vMoney.lbType.text = "đ"
//        vMoney.lbType.underlineLastCharacter()
        
        vCoin.setTextField(title: "Trao đổi Ơcoin", placeHolder: "Nhập số Ơcoin sẽ bán")
        vCoin.btnCheckBox.lbTitle.textColor = AppColor.gray_65_65_65
        vCoin.textField.keyboardType = UIKeyboardType.decimalPad
        vCoin.textField.textColor = .gray
//        vCoin.lbType.text = "ơ"
//        vCoin.lbType.underlineLastCharacter()
        
        lbNotice.textColor = AppColor.red
        
        
        vCoin.delegate = self
        vMoney.delegate = self
        vAddress1.delegate = self
        vAddress2.delegate = self
        
        vAddress1.textField.isEnabled = false
        vAddress2.textField.isEnabled = false
        vMoney.textField.isEnabled = false
        vCoin.textField.isEnabled = false
        
        vMoney.textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        vCoin.textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        vCoin.textField.delegate = self
        vMoney.setUint(unit: "đ")
        vCoin.setUint(unit: "ơ")
        //        showDataSaved()
        
    }
    
//    var index = 0
//    var characterCount = 0
    
    var tempCoinText = ""
    var isEnterComma = false
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case vMoney.textField:
            if let amountString = textField.text?.currencyInputFormatting(digit: 0) {
                vMoney.textField.text = amountString.replacingOccurrences(of: ".", with: ",")
            }
        case vCoin.textField:
            tempCoinText = vCoin.textField.text&.replacingOccurrences(of: ",", with: "")
            setTextCoin(tempCoinText: tempCoinText)
            if vCoin.isCheck && vMoney.isCheck == false {
                let money = tempCoinText.toDouble() * 20000
                print(money.description)
                vMoney.textField.text = money.toUInt64().toCurrency.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "₫", with: "")
                print(vMoney.textField.text)
            }
        
        default:
            break
        }
        
    }
    
    // 1111.00
    func setTextCoin(tempCoinText: String) {
        
        let split = tempCoinText.split(separator: ".")
        let _coin = tempCoinText.toDouble()
        // no decimal
        if split.count == 1 {
            vCoin.textField.text = _coin.toCurrencyMyBuy.replacingOccurrences(of: ".00", with: "")
        }
        // have decimal .0 or other 0
        if split.count == 2 && split[1].count == 1 {
            let result = _coin.toCurrencyMyBuy.dropLast()
            vCoin.textField.text = result.description
        }
        // have decial .00
        if split.count == 2 && split[1].count == 2 {
            let result = _coin.toCurrencyMyBuy
            vCoin.textField.text = result
        }
    }
    
    func setupUpdate() {
        if isCopyUpdate {
//            isCopyUpdate = false
            CopyUpdate()
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: "Đăng tin bán")
        setRedStatusBar()
    }
    
    //    func showDataSaved() {
    //        guard let _user = UserDefaultHelper.shared.loginUserInfo else { return }
    //        if _user.houseAddress != nil {
    //            vAddress1.textField.text = _user.houseAddress
    //        }
    //
    //        if _user.companyAddress != nil {
    //            vAddress2.textField.text = _user.companyAddress
    //        }
    //
    //    }
    
    @objc func editingChanged(textField: UITextField) {
        if vMoney.isCheck && vCoin.isCheck == false {
            let money = textField.text&.removeCommaDecimal().toDouble()
            let coin = money / AppConstant.moneyToCoint
            let num = coin.roundedTwoDemical()
            setTextCoin(tempCoinText: num)
        }
//        vCoin.textField.text = num.currencyInputFormatting(digit: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabbar()
        setupUpdate()
    }
    
    @IBAction func btnPostTapped() {
        
        if validInput() {
            var address1 = ""
            var lat1 = ""
            var long1 = ""
            
            var address2 = ""
            var lat2 = ""
            var long2 = ""
            var price = ""
            var coin = ""
            
            if vAddress1.isCheck {
                address1 = vAddress1.textField.text&
                if !isCopyUpdate {
                    lat1 = self.locationAddress1?.latitude.description& ?? ""
                    long1 = self.locationAddress1?.longitude.description& ?? ""
                } else {
                    guard let _record = record else { return }
                    lat1 = _record.lat1&
                    long1 = _record.long1&
                }
               
            }
            
            if vAddress2.isCheck {
                address2 = vAddress2.textField.text&
                if !isCopyUpdate {
                    lat2 = self.locationAddress2?.latitude.description& ?? ""
                    long2 = self.locationAddress2?.longitude.description& ?? ""
                } else {
                    guard let _record = record else { return }
                    lat2 = _record.lat2&
                    long2 = _record.long2&
                }
               
            }
            
            if vMoney.isCheck {
                price = "\(vMoney.textField.text&.removeCommaDecimal())"
            }
            
            if vCoin.isCheck {
                var tempString = vCoin.textField.text&
                tempString = tempString.replacingOccurrences(of: ",", with: "")
                let intQuality = tempString.toDouble().roundedTwoDemical()
                coin = "\(intQuality)"
            }
            
            isGPSCurrent = vCheckGPS.isChecked ? 1 : 0
             let isActivePhone = UserDefaultHelper.shared.loginUserInfo?.isActivePhone
                let isActiveZalo = UserDefaultHelper.shared.loginUserInfo?.isActiveZalo
                let isActiveFacebook = UserDefaultHelper.shared.loginUserInfo?.isActiveFacebook
            param.updateInfoStepTwo(address1: address1, lat1: lat1, long1: long1, address2: address2, lat2: lat2, long2: long2, isLatlong: true, price: price, coin: coin, isGpsCurrent: isGPSCurrent, isActivePhone: isActivePhone*, isActiveZalo: isActiveZalo*, isActiveFacebook: isActiveFacebook*)
            
            presenter?.postRecord(param: param)
        }
    }
    
    func validInput() -> Bool {
        if vAddress1.textField.text&.trim().isEmpty && vAddress2.textField.text&.trim().isEmpty && !vCheckGPS.isChecked  {
            lbNotice.text = "Vui lòng chọn địa chỉ đăng bán"
            return false
        }
        
        if vAddress1.isCheck && vAddress1.textField.text&.trim().isEmpty {
            lbNotice.text = "Vui lòng chọn địa chỉ đăng bán 1"
            return false
        }
        
        if vAddress2.isCheck && vAddress2.textField.text&.trim().isEmpty {
            lbNotice.text = "Vui lòng chọn địa chỉ đăng bán 2"
            return false
        }
        
        
        if  !vCoin.isCheck && !vMoney.isCheck && !isService {
            lbNotice.text = "Vui lòng chọn phương thức thanh toán"
            return false
        }
        
        if vMoney.isCheck {
            if !vMoney.textField.text&.isEmpty {
                let intQuality = vMoney.textField.text&.formatToDouble(digit: 0)
                if intQuality < 0 {
                    lbNotice.text = "Vui lòng nhập giá tiền"
                    return false
                }
                
                if intQuality > 999999000 {
                    lbNotice.text = "Vui lòng nhập tiền mặt không quá 999,000,000 đ"
                    return false
                }
            } else {
                lbNotice.text = "Vui lòng nhập giá tiền"
                return false
            }
        }
        
        if vCoin.isCheck {
            if !vCoin.textField.text&.isEmpty {
                var tempString = vCoin.textField.text&
                tempString = tempString.replacingOccurrences(of: ",", with: "")
                let intQuality = tempString.toDouble()
                
                if intQuality < 0 {
                    lbNotice.text = "Vui lòng nhập Ơ coin"
                    return false
                }
                if intQuality > 49950 {
                    lbNotice.text = "Vui lòng nhập ơ coin không quá 49,950 ơ"
                    return false
                }
            } else {
                lbNotice.text = "Vui lòng nhập Ơ coin"
                return false
            }
        }
        
        return true
    }
    
}

extension PostStepTwoViewController: PostStepTwoViewProtocol {
    func didPostRecord(record: RecordEntity?) {
        PopUpHelper.shared.showMessageHaveAds(message: "Đăng bán thành công")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func didError(error: APIError?) {
        guard let _message = error?.message else { return }
        if _message == "NUMBER_OF_POSTINGS_IS_OVER" {
            PopUpHelper.shared.showPopUpCanPost()
        }
    }
}

extension PostStepTwoViewController: CheckBoxTextFieldDelegate {
    func checkBoxTextField(didEndEditting checkBoxTextField: CheckBoxTextField) {
        if checkBoxTextField == vAddress2 || checkBoxTextField == vAddress1 {
            if checkBoxTextField.isCheck {
                let vc = PositionViewController.initFromNib()
                vc.checkBox = checkBoxTextField
                vc.delegate = self
                let nav = UINavigationController(rootViewController: vc)
//                viewController?.present(controller: nav)
                self.present(controller: nav)
//                PositionMapsHelper.shared.showSearchPlace(controller: self) { place in
//                    guard let _place = place as? GMSPlace else { return }
//                    checkBoxTextField.textField.text = _place.formattedAddress&
//
//                    // lat long
//                    if checkBoxTextField == self.vAddress2  {
//                        self.locationAddress2 = _place.coordinate
//                    } else {
//                        self.locationAddress1 = _place.coordinate
//                    }
//                }
                
            }
        }
    }
    
    func checkBoxTextField(checkBoxTextField: CheckBoxTextField, isChecked: Bool) {
        checkBoxTextField.textField.isEnabled = isChecked
        switch checkBoxTextField {
//        case vAddress1:
//            checkBoxTextField.textField.text = UserDefaultHelper.shared.loginUserInfo?.houseAddress
//        case vAddress2:
//            checkBoxTextField.textField.text = UserDefaultHelper.shared.loginUserInfo?.companyAddress
        case vMoney, vCoin:
            checkBoxTextField.textField.textColor = isChecked ? .black : .gray
        default:
            break
        }
    }
}

extension PostStepTwoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField == vCoin.textField {
            // when user click delete character
            if string == "" {
                return true
            }
            // user enter , the first
            if textField.text&.isEmpty && (string == "," || string == ".") {
                return false
            }
            
            // can not enter two number after "."
            let temp = vCoin.textField.text&
            let split = temp.split(separator: ".")
            if split.count > 1 && split[1].count >= 2 {
                return false
            }
            
            //-- check enter , or .
            if (string == "," || string == ".") {
                if !textField.text&.contains(".") {
                     textField.text = "\(textField.text&)."
                }
               
                return false
            }
        }
        
        return true
    }
}

extension PostStepTwoViewController: PositionViewControllerDelegate {
    func positionSelected(location: CLLocationCoordinate2D, address: String, distance: PositionRangeEntity?) {
        
    }
    
    func positionSelectedCheckBox(location: CLLocationCoordinate2D, address: String, checkBox: CheckBoxTextField) {
        // lat long
        if checkBox == self.vAddress2  {
            self.vAddress2.textField.text = address
            self.locationAddress2 = location
        } else {
            self.vAddress1.textField.text = address
            self.locationAddress1 = location
        }
    }
}
