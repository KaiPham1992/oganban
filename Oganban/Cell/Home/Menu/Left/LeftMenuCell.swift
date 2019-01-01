//
//  LeftMenuCell.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 1/1/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

protocol LeftMenuCellDelegate: class {
    func openRightMenu(indexPath: IndexPath)
}

class LeftMenuCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgCheck: UIImageView!
    
    var isSelect = false {
        didSet {
            setData()
        }
    }
    
    var indexPath: IndexPath?
    weak var delegate: LeftMenuCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionStyle = .none
        //        if isLeft {
        //            lbTitle.textColor =  selected ? .yellow : .white
        //        }
    }
    
    func setData() {
        if isSelect {
            lbTitle.textColor = UIColor.yellow
            imgCheck.image = AppImage.imgChecked
        } else {
            lbTitle.textColor = .white
            imgCheck.image = AppImage.imgCheckMenu
        }
    }
    
    @IBAction func btnOpenRightMenu() {
        if let indexPath = indexPath {
            delegate?.openRightMenu(indexPath: indexPath)
        }
    }
}
