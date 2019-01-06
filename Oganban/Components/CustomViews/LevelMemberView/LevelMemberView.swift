//
//  LevelMemberView.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
class LevelMemberView: BaseViewXib {
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbPro: UILabel!
    
    func setLevel(level: String, isPro: String?) {
        if isPro == "1" {
            lbPro.isHidden = false
        } else {
            lbPro.isHidden = true
        }
        
        self.lbLevel.text = level
    }
    
    override func setUpViews() {
        super.setUpViews()
        self.setFont()
    }
    
    func setFont(levelFont: UIFont = AppFont.fontBoldRoboto15, proFont: UIFont = AppFont.fontBoldRoboto9 ){
        lbLevel.font = levelFont
        lbPro.font = proFont
    }
}
