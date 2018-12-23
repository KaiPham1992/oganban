//
//  MoreCell.swift
//  free
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class MoreCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(index: Int){
        switch index {
        case MoreRowName.historyCoin.index():
            lbTitle.text = MoreTitle.historyCoin
            break
        case MoreRowName.historyBuy.index():
            lbTitle.text = MoreTitle.historyBuy
            break
        case MoreRowName.policy.index():
            lbTitle.text = MoreTitle.policy
            break
        case MoreRowName.tutorial.index():
            lbTitle.text = MoreTitle.tutorial
            break
        case MoreRowName.setting.index():
            lbTitle.text = MoreTitle.setting
            break
        case MoreRowName.changePassword.index():
            lbTitle.text = MoreTitle.changePassword
            break
        case MoreRowName.logout.index():
            lbTitle.text = MoreTitle.logout
            break
        default:
            break
        }
    }
}
