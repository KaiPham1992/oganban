//
//  RangeCell.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 1/19/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit
import DropDown

class RangeCell: DropDownCell {
    
    @IBOutlet weak var vContent: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vContent.backgroundColor = AppColor.main
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
}
