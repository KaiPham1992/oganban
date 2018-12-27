//
//  AcceptCell.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

protocol AcceptCellDelegate: class {
    func acceptTapped()
}

class AcceptCell: UITableViewCell {

    weak var delegate: AcceptCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        // Configure the view for the selected state
    }
    
    @IBAction func btnAcceptTapped() {
        delegate?.acceptTapped()
    }
    
}
