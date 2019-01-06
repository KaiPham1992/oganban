//
//  HistoryBuyCell.swift
//  Oganban
//
//  Created by Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class HistoryBuyCell: UITableViewCell {

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
    
    func showData(history: HistoryBuyEntity) {
        if let date = history.createTime {
            lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
        } else {
            lbDate.text = ""
        }
        
        lbContent.text = history.content
    }
}
