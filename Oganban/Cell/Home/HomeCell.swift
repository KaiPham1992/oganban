//
//  HomeCell.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCell: UICollectionViewCell {
    
    @IBOutlet weak var lbRecordName         : UILabel!
    @IBOutlet weak var lbDistanceAndTime    : UILabel!
    @IBOutlet weak var lbPrice              : UILabel!
    @IBOutlet weak var lbCoin               : UILabel!
    @IBOutlet weak var lbName               : UILabel!
    @IBOutlet weak var lbStar               : UILabel!
    @IBOutlet weak var lbLevel              : UILabel!
    @IBOutlet weak var lbPro                : UILabel!
    @IBOutlet weak var imgRecord            : UIImageView!
    @IBOutlet weak var imgNew               : UIImageView!
    @IBOutlet weak var imgAvatar            : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(record: RecordEntity) {
        lbRecordName.text = record.name
//        if let date = _notification.createTime {
//            lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
//        }
        lbDistanceAndTime.text = "\(record.distance&) | \(record.createTime&)"
        lbPrice.text = "\(record.price&) đ"
        lbPrice.underlineLastCharacter()
        lbCoin.text = "\(record.coin&) ơ"
        lbCoin.underlineLastCharacter()
        lbName.text = record.fullName
        lbStar.text = record.avgRating
        lbLevel.text = record.level
        
        if record.isNew != nil {
            imgNew.isHidden = false
        } else {
            imgNew.isHidden = true
        }
        
        if record.isPro != nil {
            lbPro.isHidden = false
        } else {
            lbPro.isHidden = true
        }
        
        if let url = URL(string: "\(BASE_URL)\(record.imgSrc&)") {
            imgRecord.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
        }
        
        if let url = URL(string: "\(BASE_URL)\(record.imgSrcAccount&)") {
            imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
        }
    }

}
