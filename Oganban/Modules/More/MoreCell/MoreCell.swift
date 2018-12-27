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
    
    func showLogout(){
        if UserDefaultHelper.shared.loginUserInfo != nil {
            lbTitle.textColor = AppColor.gray_65_65_65
            lbTitle.text = MoreTitle.logout
            vBottomLine.isHidden = false
            imgIcon.isHidden = false
        } else {
            lbTitle.textColor = AppColor.gray_200_200_200
            lbTitle.text = MoreTitle.version + " 1.0"
            vBottomLine.isHidden = true
            imgIcon.isHidden = true
        }
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
            self.showLogout()
            break
        default:
            break
        }
    }
}
