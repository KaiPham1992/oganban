//
//  RecordSellingView.swift
//  Oganban
//
//  Created by Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class RecordSellingView: BaseViewXib {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_record.imgSrc ?? "")") {
                imgProduct.sd_setImage(with: url, placeholderImage: AppImage.imgLogo)
            }
            lbProductName.text = _record.name
            lbTime.text = _record.createTime?.timeAgo()
            lbPrice.text = "\(_record.price ?? "") đ"
            lbCoin.text = "\(_record.coin ?? "") ơ"
            let qty = _record.quantity
            lbTotal.text = "SL còn lại: \(qty ?? "")"
            lbCoin.underlineLastCharacter()
            lbPrice.underlineLastCharacter()
        }
    }
    
    override func setUpViews() {
        lbCoin.underlineLastCharacter()
        lbPrice.underlineLastCharacter()
    }
}
