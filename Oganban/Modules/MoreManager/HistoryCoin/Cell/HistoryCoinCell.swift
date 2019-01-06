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
    
    func showData(history: HistoryCoinEntity){
        if let date = history.createTime {
            lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
        } else {
            lbDate.text = ""
        }
        
        if let _coin = history.coin, let coin = String(_coin).addComma() {
            lbCoin.text = coin  + " ơ"
        } else {
            lbCoin.text = "0 ơ"
        }
        
        lbContent.text = history.content
    }
}
