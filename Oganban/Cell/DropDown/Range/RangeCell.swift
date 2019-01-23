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
    @IBOutlet weak var vBottomLine: UIView!
    @IBOutlet weak var rightAnchorLabel: NSLayoutConstraint!
    @IBOutlet weak var leftAnchorLabel: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vContent.backgroundColor = AppColor.main
        vBottomLine.backgroundColor = AppColor.line_60_0_0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
}
