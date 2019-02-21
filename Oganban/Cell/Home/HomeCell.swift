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
    @IBOutlet weak var imgMoney             : UIImageView!
    @IBOutlet weak var imgcoin              : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(record: RecordEntity) {
        lbRecordName.text = record.name
//        if let date = _notification.createTime {
//            lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
//        }
        if let date = record.createTime {
            if let distance = record.distanceConvert {
                lbDistanceAndTime.text = "\(distance) | \(date.timeAgo())"
            } else {
                lbDistanceAndTime.text = "0m | \(date.timeAgo())"
            }
            
        } else {
            if let date = record.createTime {
                lbDistanceAndTime.text = "\(date.timeAgo())"
            }
            if let distance = record.distanceConvert {
                lbDistanceAndTime.text = "\(distance)"
            } else {
                lbDistanceAndTime.text = "0m"
            }
        }
        
//        lbPrice.text = record.showMoney()
        lbPrice.text = record.showMoneyHome()
        lbPrice.underlineLastCharacter()
        lbCoin.text = record.showCoin()
        lbCoin.underlineLastCharacter()
        lbName.text = record.fullName
        lbStar.text = record.ratingFormat
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
        
        if let url = URL(string: "\(BASE_URL)\(record.imgHome&)") {
            imgRecord.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
        }
        
        if let url = URL(string: "\(BASE_URL)\(record.imgSrcAccount&)") {
            imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
        }
        
        if record.coin == nil && record.price == nil {
            imgMoney.isHidden = true
            imgcoin.isHidden = true
        } else {
            imgMoney.isHidden = false
            imgcoin.isHidden = false
        }
        
        if record.coin == nil {
            imgcoin.isHidden = true
        } else {
            imgcoin.isHidden = false
        }
        
        if record.price == nil {
            imgMoney.isHidden = true
        } else {
            imgMoney.isHidden = false
        }
    }

}
