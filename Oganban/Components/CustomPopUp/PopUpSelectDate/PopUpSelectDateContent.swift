//
//  PopUpSelectDateContent.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
protocol PopUpSelectDateContentDelegate: class {
    func dateSelected(date: Date?)
}

class PopUpSelectDateContent: BaseViewXib {
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vPickerDate: UIDatePicker!
    
    weak var delegate: PopUpSelectDateContentDelegate?
    
    @IBAction func btnOkTapped() {
        delegate?.dateSelected(date: vPickerDate.date)
    }
    
    override func setUpViews() {
        super.setUpViews()
        vPickerDate.datePickerMode = .date
    }
}
