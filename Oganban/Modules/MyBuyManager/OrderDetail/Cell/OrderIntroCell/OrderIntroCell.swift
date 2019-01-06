//
//  OrderIntroCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class OrderIntroCell: BaseTableCell {
    @IBOutlet weak var lbAbout: UILabel!
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            lbAbout.text = _record.about
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
