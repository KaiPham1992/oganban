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
    
    func showData(index: Int){
        
        lbTitle.textColor = AppColor.gray_65_65_65
        vBottomLine.isHidden = false
        imgIcon.isHidden = false
        
        if index == MoreRowName.historyCoin.index() {
            lbTitle.text = MoreTitle.historyCoin
            return
        }
        
        if index == MoreRowName.historyBuy.index() {
            lbTitle.text = MoreTitle.historyBuy
            return
        }
        if index == MoreRowName.policy.index() {
            lbTitle.text = MoreTitle.policy
            return
        }
        if index == MoreRowName.tutorial.index() {
            lbTitle.text = MoreTitle.tutorial
            return
        }
        if index == MoreRowName.setting.index(){
            lbTitle.text = MoreTitle.setting
            return
        }
        
        if UserDefaultHelper.shared.loginUserInfo != nil {
            if index == MoreRowName.changePassword.index(){
                lbTitle.text = MoreTitle.changePassword
                return
            }
            if index == MoreRowName.logout.index(){
                lbTitle.text = MoreTitle.logout
                return
            }
        }
        
        if index == MoreRowName.version.index() {
            lbTitle.textColor = AppColor.gray_200_200_200
            lbTitle.text = MoreTitle.version + " 1.0"
            vBottomLine.isHidden = true
            imgIcon.isHidden = true
            return
        }
    }
}
