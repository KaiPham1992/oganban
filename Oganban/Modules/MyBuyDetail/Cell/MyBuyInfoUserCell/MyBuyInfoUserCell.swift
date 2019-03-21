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
    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnZalo: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBOutlet weak var lcsWidthBtnPhone: NSLayoutConstraint!
    @IBOutlet weak var lcsWidthBtnZalo: NSLayoutConstraint!
    
    weak var delegate: MyBuyInfoUserCellDelegate?
    
    override func awakeFromNib() {
        imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: imgAvatar.frame.width / 2)
    }
    
    func setData(orderDetail: OrderDetailEntity?, isSaler: Bool) {
        guard let _record = orderDetail else { return }
        
        if !isSaler {
            lbStar.text = _record.avgRatingSaler?.roundedDemical()
            lbReview.text = _record.showTotolRatingSaler()
//            lbPhone.text = _record.showFullPhoneSaler()
            lbName.text = _record.fullNameSaler
            vLevel.setLevel(level: _record.levelSaler&, isPro: _record.isProSaler)
            imgAvatar.sd_setImage(with: _record.urlAvatarSaler, placeholderImage: AppImage.imgDefaultUser)
//            lcsWithImgPhone.constant = 0
//            btnPhone.isEnabled = false
            
            if _record.isPhoneBuyer != nil  {
                lcsWidthBtnPhone.constant = 35
            } else {
                lcsWidthBtnPhone.constant = 0
            }
            
            if let _ = _record.isZaloBuyer {
                lcsWidthBtnZalo.constant = 35
                
            } else {
                lcsWidthBtnZalo.constant = 0
            }
            
            if let _ = _record.isZaloBuyer {
                
                btnFacebook.isHidden =  false
            } else {
                btnFacebook.isHidden = true
            }
        } else {
            lbStar.text = _record.avgRatingBuyer?.roundedDemical()
            lbReview.text = _record.showTotolRatingBuyer()
//            lbPhone.text = _record.showFullPhoneBuyer()
            lbName.text = _record.fullNameBuyer
            vLevel.setLevel(level: _record.levelBuyer&, isPro: _record.isProBuyer)
            imgAvatar.sd_setImage(with: _record.urlAvatarBuyer, placeholderImage: AppImage.imgDefaultUser)
//            lcsWithImgPhone.constant = 20
//            btnPhone.isEnabled = true
            if _record.isPhoneSeller == nil {
                 lcsWidthBtnPhone.constant = 35
            } else {
                lcsWidthBtnPhone.constant = 0
            }
            
            if let _ = _record.isZaloSeller {
                lcsWidthBtnZalo.constant = 35
                
            } else {
                lcsWidthBtnZalo.constant = -35
            }
            
            if let _ = _record.isFacebookSeller {
                
                btnFacebook.isHidden =  false
            } else {
                btnFacebook.isHidden = true
            }
        }
    }
    
    @IBAction func btnPhoneTapped() {
        delegate?.btnPhoneTapped()
    }
}
