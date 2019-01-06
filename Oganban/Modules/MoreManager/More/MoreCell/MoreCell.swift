//
//  MoreCell.swift
//  free
//
//  Created by Kent on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var vTopLine: UIView!
    @IBOutlet weak var vBottomLine: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbTitle.textColor = AppColor.gray_65_65_65
        vBottomLine.isHidden = false
        imgIcon.isHidden = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func showData(type: MoreEntityType){
        
        lbTitle.textColor = AppColor.gray_65_65_65
        vBottomLine.isHidden = false
        imgIcon.isHidden = false
        lbTitle.text = type.rawValue
        
        if type == .version {
            lbTitle.textColor = AppColor.gray_200_200_200
            lbTitle.text = type.rawValue + " 1.0"
            vBottomLine.isHidden = true
            imgIcon.isHidden = true
            return
        }
    }
}
