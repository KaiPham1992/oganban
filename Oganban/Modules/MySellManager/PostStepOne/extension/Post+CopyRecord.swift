//
//  Post+CopyRecord.swift
//  Oganban
//
//  Created by Ngoc Duong on 1/8/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

extension PostStepOneViewController {
    
    func setupUpdate() {
        lbCategory.text = ""
        vTitleRecord.textField.text = record?.name
        vQuantity.textField.text = "\(record?.quantity ?? 0)"
        vChooseDate.textField.text = ""
        vAbout.tvInput.text = record?.about
        vAbout.lbPlaceHolder.text = ""
    
    }
}

