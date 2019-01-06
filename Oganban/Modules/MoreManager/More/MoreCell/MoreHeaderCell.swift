//
//  MoreHeaderCell.swift
//  free
//
//  Created by Kent on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit
import SDWebImage

class MoreHeaderCell: UITableViewCell {
    
    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCoinTotal: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivAvatar.layer.cornerRadius = ivAvatar.frame.width / 2.0
        ivAvatar.layer.masksToBounds = true
    }
    
    func setupView() {
        
        if UserDefaultHelper.shared.loginUserInfo != nil, let user: UserEntity = UserDefaultHelper.shared.loginUserInfo {
            
            lbCoinTotal.isHidden = false
            lbPhone.isHidden = false
            vLevel.isHidden = false
            lbName.font = AppFont.fontRegularRoboto15
            lbName.textColor = AppColor.black
            self.showData(user: user)
        } else {

            lbCoinTotal.isHidden = true
            lbPhone.isHidden = true
            vLevel.isHidden = true
            ivAvatar.image = AppImage.imgDefaultUser
            lbName.font = AppFont.fontBoldRoboto15
            lbName.textColor = AppColor.blue_0_136_241
            lbName.text = MoreTitle.loginSignup
        }
    }
    
    func showData(user: UserEntity) {
        lbName.text = user.fullName
        
        if let phoneCode = user.phoneCode, let phone = user.phone {
            lbPhone.text = phoneCode + phone
        }
        
        vLevel.setLevel(level: user.level&, isPro: user.isPro)
        ivAvatar.sd_setImage(with: user.urlAvatar , placeholderImage: AppImage.imgDefaultUser)
        if let _coin = user.coin, let coin = String(_coin).addComma() {
            lbCoinTotal.text = "Tổng ƠCoin tích luỹ: " + coin  + " ơ"
        } else {
            lbCoinTotal.text = "Tổng ƠCoin tích luỹ: 0 ơ"
        }
    }
}
