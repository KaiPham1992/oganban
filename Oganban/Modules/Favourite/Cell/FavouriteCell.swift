//
//  FavouriteCell.swift
//  Oganban
//
//  Created by Admin on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: UIColor.clear, cornerRadius: imgAvatar.frame.width / 2.0)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
