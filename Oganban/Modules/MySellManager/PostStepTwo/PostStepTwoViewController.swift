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
        vMoney.textField.addTarget(self, action: #selector(editingChanged), for: UIControl.Event.editingChanged)
//        vMoney.lbType.text = "đ"
//        vMoney.lbType.underlineLastCharacter()
        
        vCoin.setTextField(title: "Trao đổi Ơcoin", placeHolder: "Nhập số Ơcoin sẽ bán")
        vCoin.btnCheckBox.lbTitle.textColor = AppColor.gray_65_65_65
        vCoin.textField.keyboardType = UIKeyboardType.numberPad
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
        
        vMoney.setUint(unit: "đ")
        vCoin.setUint(unit: "ơ")
        //        showDataSaved()
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case vMoney.textField:
            if let amountString = textField.text?.currencyInputFormatting(digit: 0) {
                vMoney.textField.text = amountString
            }
        case vCoin.textField:
            if let amountString = textField.text?.currencyInputFormatting(digit: 2) {
               vCoin.textField.text = amountString
            }
        default:
            break
        }
        
    }
    
    func setupUpdate() {
        if isCopyUpdate {
            isCopyUpdate = false
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
        let money = textField.text&.formatToDouble(digit: 0)
        let coin = money / AppConstant.moneyToCoint
        vCoin.textField.text = coin.roundedTwoDemical()
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
            
            if vAddress1.isCheck {
                address1 = vAddress1.textField.text&
                lat1 = self.locationAddress1?.latitude.description& ?? ""
                long1 = self.locationAddress1?.longitude.description& ?? ""
            }
            
            if vAddress2.isCheck {
                address2 = vAddress2.textField.text&
                lat2 = self.locationAddress2?.latitude.description& ?? ""
                long2 = self.locationAddress2?.longitude.description& ?? ""
            }
            
            let price = "\(vMoney.textField.text&.formatToDouble(digit: 0))"
            let coin = "\(vCoin.textField.text&.formatToDouble(digit: 2))"
            
            isGPSCurrent = vCheckGPS.isChecked ? 1 : 0
            
            param.updateInfoStepTwo(address1: address1, lat1: lat1, long1: long1, address2: address2, lat2: lat2, long2: long2, isLatlong: false, price: price, coin: coin, isGpsCurrent: isGPSCurrent)
            
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
            if let intQuality = Double(vMoney.textField.text&.replacingOccurrences(of: ".", with: "")) {
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
            if let intQuality = Double(vCoin.textField.text&) {
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
                PositionMapsHelper.shared.showSearchPlace(controller: self) { place in
                    guard let _place = place as? GMSPlace else { return }
                    checkBoxTextField.textField.text = _place.formattedAddress&
                    
                    // lat long
                    if checkBoxTextField == self.vAddress2  {
                        self.locationAddress2 = _place.coordinate
                    } else {
                        self.locationAddress1 = _place.coordinate
                    }
                }
                
            }
        }
    }
    
    func checkBoxTextField(checkBoxTextField: CheckBoxTextField, isChecked: Bool) {
        checkBoxTextField.textField.isEnabled = isChecked
    }
}
