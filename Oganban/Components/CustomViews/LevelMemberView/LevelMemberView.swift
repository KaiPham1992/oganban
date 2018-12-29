//
//  LevelMemberView.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

enum LevelMemberType: String {
    case member = "Member"
    case sliver = "Sliver"
    case titan = "Titan"
    case gold = "Gold"
    case platinum = "Platinum"
    case diamond = "Diamond"
}

class LevelMemberView: BaseViewXib {
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbPro: UILabel!
    
    var levelType: LevelMemberType =  LevelMemberType.member {
        didSet {
            self.lbLevel.text = levelType.rawValue
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        self.levelType = .member
    }
}
