//
//  File.swift
//  Oganban
//
//  Created by Ngoc Duong on 1/8/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

extension PostStepTwoViewController {
    func CopyUpdate() {
        vAddress1.textField.text = record?.address1
        vAddress2.textField.text = record?.address2
        
        if record?.address1 != nil && record?.address1 != "" {
            vAddress1.btnCheckBox.isChecked = true
            vAddress1.textField.isEnabled = true 
        }
        if record?.address2 != nil && record?.address2 != "" {
            vAddress2.btnCheckBox.isChecked = true
            vAddress2.textField.isEnabled = true
            
        }
        if record?.price != nil && record?.price != 0 {
            vMoney.btnCheckBox.isChecked = true
            vMoney.textField.isEnabled = true
            guard let price = record?.price else { return }
            vMoney.textField.text = "\(Int(price) )"
        }
        if record?.coin != nil && record?.coin != 0 {
            vCoin.btnCheckBox.isChecked = true
            vCoin.textField.isEnabled = true
            guard let coin = record?.coin else { return }
            vCoin.textField.text = "\(Int(coin))"

        }
    }
}
