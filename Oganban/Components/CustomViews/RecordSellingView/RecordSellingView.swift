//
//  RecordSellingView.swift
//  Oganban
//
//  Created by Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit

class RecordSellingView: BaseViewXib {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    override func setUpViews() {
        lbCoin.underlineLastCharacter()
        lbPrice.underlineLastCharacter()
    }
}
