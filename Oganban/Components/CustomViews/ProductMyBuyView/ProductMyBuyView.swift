//
//  ProductView.swift
//  Oganban
//
//  Created by Coby on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit
class ProductMyBuyView: BaseViewXib {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    override func setUpViews() {
        imgAvatar.setBorderWithCornerRadius()
        lbStatus.isHidden = true
        lbPrice.underlineLastCharacter()
    }
}
