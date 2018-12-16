//
//  LeftAlignCollectionCell.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class LeftAlignCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lbTitle: AppLabel!
    
    var item: Any? {
        didSet {
            if let projectType = item as? ProjectTypeEntity {
                self.lbTitle.text = projectType.name
                
                // set style
                if projectType.isSelected {
                    self.lbTitle.backgroundColor = AppColor.green
                    self.lbTitle.textColor = AppColor.white
                } else {
                    self.lbTitle.backgroundColor = AppColor.clear
                    self.lbTitle.textColor = AppColor.gray
                }
            }
            
            //---
            if let level = item as? LevelEntity {
                self.lbTitle.text = level.name
                
                // set style
                if level.isSelected {
                    self.lbTitle.backgroundColor = AppColor.green
                    self.lbTitle.textColor = AppColor.white
                } else {
                    self.lbTitle.backgroundColor = AppColor.clear
                    self.lbTitle.textColor = AppColor.gray
                }
                
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbTitle.setBorder(borderWidth: 1, borderColor: AppColor.gray, cornerRadius: 5)
    }

}
