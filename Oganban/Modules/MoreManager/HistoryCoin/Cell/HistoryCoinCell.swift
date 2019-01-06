//
//  HistoryCoinCell.swift
//  Oganban
//
//  Created by Admin on 1/4/19.
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
    
}
