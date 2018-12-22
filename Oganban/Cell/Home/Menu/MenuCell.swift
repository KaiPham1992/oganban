//
//  MenuCell.swift
//  DemoDropdown
//
//  Created by DINH VAN TIEN on 12/17/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
        lbTitle.textColor =  selected ? .yellow : .white
    }
    
}
