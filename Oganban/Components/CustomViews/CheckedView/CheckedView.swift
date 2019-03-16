//
//  CheckedView.swift
//  Oganban
//
//  Created by Coby on 3/16/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class CheckedView: BaseViewXib {
    
    @IBOutlet weak var imgChecked: UIImageView!
    
    var isChecked = false
    
    override func setUpViews() {
        
        imgChecked.image = UIImage(named: "ic_check_off")
    }
    
    @IBAction func btnCheckedTapped() {
        isChecked = !isChecked
        if isChecked {
            imgChecked.image = UIImage(named: "ic_check_on")
        } else {
            imgChecked.image = UIImage(named: "ic_check_off")
        }
    }
}
