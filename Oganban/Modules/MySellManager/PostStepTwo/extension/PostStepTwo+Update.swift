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
        vMoney.textField.text = "\(record?.price ?? 0)"
        vCoin.textField.text = "\(record?.coin ?? 0)"
    }
}
