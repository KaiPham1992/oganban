//
//  MyBuyCell.swift
//  Oganban
//
//  Created by Coby on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class MyBuyCell: BaseTableCell {

    @IBOutlet weak var vMyBuyView: ProductMyBuyView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
