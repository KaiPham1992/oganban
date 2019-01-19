//
//  File.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import DropDown
import ObjectMapper

protocol PhoneNumberDelegate: class {
    func phoneCodeChoose(info: CountryCodeEntity)
}

class PhoneNumber: BaseViewXib {
    
    @IBOutlet weak var tfPhone          : UITextField!
    @IBOutlet weak var lbCountryCode    : UILabel!
    @IBOutlet weak var vDropdown        : UIView!
    
    var textFieldDidBeginEditing : (() -> Void)?
    var textFieldDidChange : (() -> Void)?
    let phoneDropDown = DropDown()
    var listCode: [CountryCodeEntity] = []
    var phoneCode = ""
    weak var delegate: PhoneNumberDelegate?
    
    var fullPhone: String {
        return "\(lbCountryCode.text&)\(tfPhone.text&)"
    }
    
    override func setUpViews() {
        super.setUpViews()
        setUpDropDown()
        readCountryCode()
    }
    
    @IBAction func btnDropdownTapped() {
        phoneDropDown.show()
    }
    
    func setUpDropDown() {
        phoneDropDown.anchorView = vDropdown
        phoneDropDown.width = 250
        phoneDropDown.cellNib = UINib(nibName: "DropdownPhoneCell", bundle:  nil)
        phoneDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let _ = cell as? DropdownPhoneCell else { return }
        }
        // Action triggered on selection
        phoneDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.phoneCode = self.listCode[index].code&
            self.lbCountryCode.text = self.listCode[index].dialCode
            self.delegate?.phoneCodeChoose(info: self.listCode[index])
        }
        phoneDropDown.dataSource = ["a", "b", "c"]
        
        tfPhone.delegate = self
        tfPhone.attributedPlaceholder = NSAttributedString(string: "Nhập số điện thoại",attributes: [NSAttributedString.Key.foregroundColor: AppColor.black414141])
        
        tfPhone.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func readCountryCode() {
        if let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                guard let object = Mapper<BaseCodeEntity>().map(JSONObject: jsonResult) else { return }
                listCode = object.data
                phoneDropDown.dataSource = listCode.map({"\($0.name&)(\($0.dialCode&))"})
            } catch {
                // handle error
            }
        }
    }
}
extension PhoneNumber: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let complete = self.textFieldDidBeginEditing {
            complete()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let complete = self.textFieldDidChange {
            complete()
        }
    }
}
