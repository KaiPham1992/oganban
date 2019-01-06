//
//  AddressCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class AddressCell: BaseTableCell {
    @IBOutlet weak var lbAddress: UILabel!
    
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            var str = ""
            if let _address1 = _record.address1 {
                str = "- \(_address1)"
            }
            
            if let _address2 = _record.address2 {
                str = "\(str)\n- \(_address2)"
            }
            lbAddress.text = str
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
