//
//  OrderInfoUserCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SDWebImage

class MyBuyInfoUserCell: BaseTableCell {
    @IBOutlet weak var lbReview: UILabel!
    @IBOutlet weak var lbStar: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    var recordMyBuy: OrderDetailEntity? {
        didSet {
            guard let _record = recordMyBuy else { return }
            lbStar.text = _record.avgRatingBuyer&
            lbReview.text = _record.showTotolRatingBuyer()
            lbPhone.text = _record.showFullPhoneBuyer()
            lbName.text = _record.fullNameBuyer
            vLevel.setLevel(level: _record.levelBuyer&, isPro: _record.isProBuyer)
            imgAvatar.sd_setImage(with: _record.urlAvatarBuyer, placeholderImage: AppImage.imgPlaceHolderImage)
        }
    }
}
