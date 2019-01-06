//
//  ProductListCell.swift
//  Oganban
//
//  Created by Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {

    @IBOutlet weak var lbRecordName         : UILabel!
    @IBOutlet weak var lbDistanceAndTime    : UILabel!
    @IBOutlet weak var lbPrice              : UILabel!
    @IBOutlet weak var lbCoin               : UILabel!
    @IBOutlet weak var lbStar               : UILabel!
    @IBOutlet weak var imgRecord            : UIImageView!
    @IBOutlet weak var imgNew               : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showData(record: RecordEntity) {
        
        lbRecordName.text = record.name
        
        if let date = record.createTime, let distance = record.distanceConvert {
            lbDistanceAndTime.text = "\(distance) | \(date.timeAgo())"
        } else {
            if let date = record.createTime {
                lbDistanceAndTime.text = "\(date.timeAgo())"
            }
            if let distance = record.distanceConvert {
                lbDistanceAndTime.text = "\(distance)"
            }
        }
        
        if let pointRatingAvg = record.avgRating, let pointRating = Float(pointRatingAvg) {
            lbStar.text =  String(format: "%.1f", pointRating)
        } else {
            lbStar.text =  String(format: "%.1f", 0)
        }
        
        if record.isNew != nil {
            imgNew.isHidden = false
        } else {
            imgNew.isHidden = true
        }
        
        if let url = URL(string: "\(BASE_URL)\(record.imgHome&)") {
            imgRecord.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
        }
        
        lbPrice.text = record.showMoney()
        lbPrice.underlineLastCharacter()
        lbCoin.text = record.showCoin()
        lbCoin.underlineLastCharacter()
        
        
    }
}
