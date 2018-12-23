//
//  PopUpUpdateQuantityBuyContent.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class PopUpUpdateQuantityBuyContent: BaseViewXib, UITextFieldDelegate {
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var btnCompleted: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        tfQuantity.delegate = self
        tfQuantity.addTarget(self, action: #selector(didTextChanged), for: UIControl.Event.editingChanged)
        tfQuantity.keyboardType = UIKeyboardType.numberPad
    }
    
    @objc func didTextChanged(sender: UITextField) {
        if sender.text&.isEmpty {
            btnCompleted.backgroundColor = AppColor.gray_200_200_200
            btnCompleted.setTitleColor(AppColor.gray_65_65_65, for: .normal)
        } else {
            btnCompleted.backgroundColor = AppColor.green
            btnCompleted.setTitleColor(AppColor.white, for: .normal)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count == 0 {
            return true
        }
        do {
            if textField == self.tfQuantity {
                
                let nString = textField.text as NSString?
                let newString = nString?.replacingCharacters(in: range, with: string)
                let expression = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"
                let regex = try NSRegularExpression(pattern: expression, options: .caseInsensitive)
                let numberOfMatches = regex.numberOfMatches(in: newString! as String, options: [], range: NSRange(location: 0, length: newString&.count))
                
                if numberOfMatches == 0 {
                    print("Can not enter string")
                    return false
                }
            }
        }
        catch let error {
            print("PopUpUpdateQuantityBuyContent: \(error.localizedDescription)")
        }
        return true
    }
}
