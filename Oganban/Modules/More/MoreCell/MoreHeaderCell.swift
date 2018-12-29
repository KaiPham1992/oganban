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
    
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCoinTotal: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivAvatar.layer.cornerRadius = ivAvatar.frame.width / 2.0
        ivAvatar.layer.masksToBounds = true
        lbLevel.font = AppFont.fontBoldRoboto15
        lbLevel.textColor = AppColor.blue_0_136_241
    }
    
    func setupView() {
        
        if UserDefaultHelper.shared.loginUserInfo != nil, let user: UserEntity = UserDefaultHelper.shared.loginUserInfo {
            
            lbCoinTotal.isHidden = false
            lbPhone.isHidden = false
            lbLevel.isHidden = false
            lbName.font = AppFont.fontRegularRoboto15
            lbName.textColor = AppColor.black
            self.showData(user: user)
        } else {

            lbCoinTotal.isHidden = true
            lbPhone.isHidden = true
            lbLevel.isHidden = true
            ivAvatar.image = AppImage.imgDefaultUser
            lbName.font = AppFont.fontBoldRoboto15
            lbName.textColor = AppColor.blue_0_136_241
            lbName.text = MoreTitle.loginSignup
            
        }
    }
    
    func showData(user: UserEntity) {
        lbName.text = user.fullName
        lbPhone.text = user.phone
        lbLevel.text = user.level
        
        if let urlString = user.imgCropSrc, let url = URL(string: BASE_URL_IMAGE + urlString) {
            ivAvatar.sd_setImage(with: url , placeholderImage: AppImage.imgDefaultUser)
        } else if let urlString = user.socialImage, let url = URL(string: urlString) {
            ivAvatar.sd_setImage(with: url , placeholderImage: AppImage.imgDefaultUser)
        }
        
        let num: Double = 30005.12
        let numString = String(num)
        
        if let coin = numString.addComma() {
            lbCoinTotal.text = "Tổng ƠCoin tích luỹ: " + coin  + " ơ"
        }
    }
}
