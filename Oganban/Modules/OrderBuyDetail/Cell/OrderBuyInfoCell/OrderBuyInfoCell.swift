//
//  OrderInfoUserCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SDWebImage

protocol OrderBuyInfoCellDelegate: class {
    func btnPhoneTapped()
    func btnZaloTapped()
    func btnFacebookTapped()
}

class OrderBuyInfoCell: BaseTableCell {
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
    weak var delegate: OrderBuyInfoCellDelegate?
    
    var record: RecordEntity? {
        didSet {
            
            guard let _record = record else { return }
            lbStar.text = _record.avgRating?.roundedDemical()
            lbReview.text = _record.totalRating& + " đánh giá"
            var phoneStr = _record.phone&
            phoneStr.remove(at: phoneStr.startIndex)
            lbName.text = _record.fullName
            vLevel.setLevel(level: _record.level&, isPro: _record.isPro)
            if _record.socialImgSrc != nil {
                imgAvatar.sd_setImage(with: _record.urlAvatarSocial, placeholderImage: AppImage.imgPlaceHolderImage)
            } else {
                imgAvatar.sd_setImage(with: _record.urlAvatar, placeholderImage: AppImage.imgPlaceHolderImage)
            }
            
            if UserDefaultHelper.shared.loginUserInfo?.id == record?.accountId {
                btnZalo.isEnabled = false
                btnPhone.isEnabled = false
                btnFacebook.isEnabled = false
            } else {
                btnZalo.isEnabled = true
                btnPhone.isEnabled = true
                btnFacebook.isEnabled = true
            }
            
            if let _ = _record.isPhone {
                lcsWidthBtnPhone.constant  =  35
            } else {
                lcsWidthBtnPhone.constant = 0
            }
            
            if let _ = _record.isZalo {
                lcsWidthBtnZalo.constant = 35
                
            } else {
                lcsWidthBtnZalo.constant = 0
            }
            
            if let _ = _record.isFacebook {
                
                btnFacebook.isHidden =  false
            } else {
                btnFacebook.isHidden = true
            }
        }
    }

    @IBAction func btnPhoneTapped() {
        delegate?.btnPhoneTapped()
    }
    
    @IBAction func btnZaloTapped() {
        delegate?.btnZaloTapped()
    }
    
    @IBAction func btnFacebookTapped() {
        delegate?.btnFacebookTapped()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        btnPhone.isHidden = true
//        lcsWidthImgPhone.constant = 0
        imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: imgAvatar.frame.width / 2)
    }
    
}
