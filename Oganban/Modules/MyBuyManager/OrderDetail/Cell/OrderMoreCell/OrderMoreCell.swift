//
//  OrderMoreCell.swift
//  Oganban
//
//  Created by Kai Pham on 1/13/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

protocol OrderMoreCellDelegate: class {
    func orderMoreCell(_ orderMoreCell: OrderMoreCell, section: Int)
}

class OrderMoreCell: BaseTableCell {
    weak var delegate: OrderMoreCellDelegate?
    @IBOutlet weak var btnMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnMoreTapped() {
        delegate?.orderMoreCell(self, section: self.btnMore.tag)
    }
    
}
