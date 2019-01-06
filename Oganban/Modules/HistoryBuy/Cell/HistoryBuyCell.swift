//
//  HistoryBuyCell.swift
//  Oganban
//
//  Created by Admin on 1/5/19.
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
    
    func showData(index: Int) {
        if index == 0 {
            lbContent.text = "dạhcdjhcbkj\nhadbaskjda/ndaskjdhasjd"
        } else {
            lbContent.text = "dạhcdjhcbkjhadbaskjda"
        }
    }
}
