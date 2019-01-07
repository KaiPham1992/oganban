//
//  OrderInfoUserCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SDWebImage

protocol OrderInfoUserCellDelegate: class {
    func btnPhoneTapped()
}

class OrderInfoUserCell: BaseTableCell {
    @IBOutlet weak var lbReview: UILabel!
    @IBOutlet weak var lbStar: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var lcsWidthImgPhone: NSLayoutConstraint!
    
    weak var delegate: OrderInfoUserCellDelegate?
    
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            lbStar.text = _record.avgRating
            lbReview.text = _record.totalRating& + " đánh giá"
            lbPhone.text = "+84" + _record.phone&
            lbName.text = _record.fullName
            vLevel.setLevel(level: _record.level&, isPro: _record.isPro)
            imgAvatar.sd_setImage(with: _record.urlAvatar, placeholderImage: AppImage.imgPlaceHolderImage)
        }
    }

    @IBAction func btnPhoneTapped() {
        delegate?.btnPhoneTapped()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPhone.isHidden = true
        lcsWidthImgPhone.constant = 0
    }
    
}
