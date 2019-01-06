//
//  MySellingCell.swift
//  Oganban
//
//  Created by Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class MySellingCell: BaseTableCell {

    @IBOutlet weak var vRecordSelling: RecordSellingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addLineToBottom()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
