//
//  CheckedView.swift
//  Oganban
//
//  Created by Coby on 3/16/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

protocol CheckedViewDelegate: class {
    func btnCheckedTapped()
}

class CheckedView: BaseViewXib {
    
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var btnChecked: UIButton!
    var isChecked = false
    
    weak var delegate: CheckedViewDelegate?
    
    override func setUpViews() {
        
        if isChecked {
            imgChecked.image = UIImage(named: "ic_check_on")
        } else {
            imgChecked.image = UIImage(named: "ic_check_off")
        }
    }
    
    func setShowChecked(checked: Bool) {
        if checked == true {
            isChecked = true
            imgChecked.image = UIImage(named: "ic_check_on")
        } else {
            imgChecked.image = UIImage(named: "ic_check_off")
            isChecked = false
        }
    }
    
    @IBAction func btnCheckedTapped() {
        isChecked = !isChecked
        if isChecked {
            imgChecked.image = UIImage(named: "ic_check_on")
        } else {
            imgChecked.image = UIImage(named: "ic_check_off")
        }
        
        delegate?.btnCheckedTapped()
    }
    
    func setCheckedShowPhone(isChecked: Bool) -> Int {
        if isChecked {
            return 1
        } else {
            return 0
        }
    }
}
