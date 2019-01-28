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
    @IBOutlet weak var imgMoney: UIImageView!
    @IBOutlet weak var imgCoin: UIImageView!
    
    var isHideOrExpired: Bool = false
    
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_record.imgHome ?? "")") {
                imgProduct.sd_setImage(with: url, placeholderImage: AppImage.imgLogo)
            }
            lbProductName.text = _record.name
            lbTime.text = _record.createTime?.timeAgo()
            if _record.price == nil {
                imgMoney.isHidden = true
            } else {
                imgMoney.isHidden = false
            }
            
            if _record.coin == nil {
                imgCoin.isHidden = true
            } else {
                imgCoin.isHidden = false
            }
            lbPrice.text = _record.showMoney()
            lbCoin.text = _record.showCoin() //"\(_record.coin?.description ?? "") ơ"
            lbCoin.underlineLastCharacter()
            lbPrice.underlineLastCharacter()
            
            
            
            if _record.status == "expired" {
                lbTotal.text = "Tin hết hạn"
                lbTotal.backgroundColor = AppColor.yellow_228_251_30
                lbTotal.textColor = AppColor.red_233_1_1
            } else if _record.status == "hide" {
                lbTotal.text = "Tin đã ẩn"
                lbTotal.backgroundColor = AppColor.gray_233_233_234
                lbTotal.textColor = AppColor.red_233_1_1
            } else {
                let qty = _record.quantity
                lbTotal.text = "SL còn lại: \(qty?.description ?? "")"
            }
            
        }
    }
    
    override func setUpViews() {
        lbCoin.underlineLastCharacter()
        lbPrice.underlineLastCharacter()
    }
}
