//
//  OrderInfoUserCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SDWebImage

protocol MyBuyInfoUserCellDelegate: class {
    func btnPhoneTapped()
}

class MyBuyInfoUserCell: BaseTableCell {
    @IBOutlet weak var lbReview: UILabel!
    @IBOutlet weak var lbStar: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var lcsWithImgPhone: NSLayoutConstraint!
    @IBOutlet weak var btnPhone: UIButton!
    
    weak var delegate: MyBuyInfoUserCellDelegate?
    
    override func awakeFromNib() {
        imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: imgAvatar.frame.width / 2)
    }
    
    func setData(orderDetail: OrderDetailEntity?, isSaler: Bool) {
        guard let _record = orderDetail else { return }
        
        if !isSaler {
            lbStar.text = _record.avgRatingSaler?.roundedDemical()
            lbReview.text = _record.showTotolRatingSaler()
            lbPhone.text = _record.showFullPhoneSaler()
            lbName.text = _record.fullNameSaler
            vLevel.setLevel(level: _record.levelSaler&, isPro: _record.isProSaler)
            imgAvatar.sd_setImage(with: _record.urlAvatarSaler, placeholderImage: AppImage.imgDefaultUser)
            lcsWithImgPhone.constant = 0
            btnPhone.isEnabled = false
        } else {
            lbStar.text = _record.avgRatingBuyer?.roundedDemical()
            lbReview.text = _record.showTotolRatingBuyer()
            lbPhone.text = _record.showFullPhoneBuyer()
            lbName.text = _record.fullNameBuyer
            vLevel.setLevel(level: _record.levelBuyer&, isPro: _record.isProBuyer)
            imgAvatar.sd_setImage(with: _record.urlAvatarBuyer, placeholderImage: AppImage.imgDefaultUser)
            lcsWithImgPhone.constant = 20
            btnPhone.isEnabled = true
        }
    }
    
    @IBAction func btnPhoneTapped() {
        delegate?.btnPhoneTapped()
    }
}
