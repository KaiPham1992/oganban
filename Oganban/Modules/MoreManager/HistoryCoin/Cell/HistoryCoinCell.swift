//
//  HistoryCoinCell.swift
//  Oganban
//
//  Created by Kent on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class HistoryCoinCell: UITableViewCell {

    @IBOutlet weak var lbCoin: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(history: HistoryCoinEntity) {
        
        if let content =  history.content {
            lbContent.text = content
        } else {
            lbContent.text = " "
        }
        
        if let date = history.createTime {
            lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
        } else {
            lbDate.text = ""
        }
        
        if let _coin = history.coin, let coin = String(_coin).addComma() {
            if _coin >= 0 {
                lbCoin.attributedText = self.getAttributedCoin(coin: ("+" + coin + " ") ,color: AppColor.green005800)
            } else {
                lbCoin.attributedText = self.getAttributedCoin(coin: (coin + " ") ,color: AppColor.red_210_2_2)
            }
        } else {
            lbCoin.attributedText = self.getAttributedCoin(coin: "0 " ,color: AppColor.green005800)
        }
        
        
    }
    
    func getAttributedCoin(coin: String, color: UIColor = AppColor.black414141, font: UIFont =  AppFont.fontRegular13) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString()
        let attr1 = coin.toAttributedString(color: color, font: font, isUnderLine: false)
        let attr2 = "ơ".toAttributedString(color: color, font: font, isUnderLine: true)
        attr.append(attr1)
        attr.append(attr2)
        return attr
    }
}
