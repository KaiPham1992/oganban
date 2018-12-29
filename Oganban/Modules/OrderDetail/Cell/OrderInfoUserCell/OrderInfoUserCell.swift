//
//  OrderInfoUserCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SDWebImage

class OrderInfoUserCell: BaseTableCell {
    @IBOutlet weak var lbReview: UILabel!
    @IBOutlet weak var lbStar: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            lbStar.text = _record.avgRating
            lbReview.text = _record.totalRating& + " đánh giá"
            lbPhone.text = _record.phone
            lbName.text = _record.fullName
            vLevel.setLevel(level: _record.level&, isPro: _record.isPro)
            imgAvatar.sd_setImage(with: _record.urlAvatar, placeholderImage: AppImage.imgPlaceHolderImage)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
