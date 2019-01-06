//
//  FavouriteCell.swift
//  Oganban
//
//  Created by Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

protocol FavouriteCellProtocol: class {
    func removeFavourite(index: Int)
}
class FavouriteCell: UITableViewCell {

    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var vLevel: LevelMemberView!
    weak var delegate: FavouriteCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: UIColor.clear, cornerRadius: imgAvatar.frame.width / 2.0)
       vLevel.setFont(levelFont: AppFont.fontBoldRoboto11, proFont: AppFont.fontBoldRoboto9)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func showData(index: Int, favourite: FavouriteEntity){
        
        btnFavourite.tag = index
        
        lbName.text = favourite.name
        
        if let date = favourite.createTime {
            lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
        } else {
            lbDate.text = ""
        }
       
        if let pointRatingAvg = favourite.pointRatingAvg, let pointRating = Float(pointRatingAvg) {
            lbRating.text =  String(format: "%.1f", pointRating)
        } else {
            lbRating.text =  String(format: "%.1f", 0)
        }
        
        imgAvatar.sd_setImage(with: favourite.urlAvatar , placeholderImage: AppImage.imgDefaultUser)
        
 
        if favourite.level != nil {
            vLevel.lbLevel.text = favourite.level

            if favourite.isPro == "1" {
                vLevel.lbPro.isHidden = false
                vLevel.lbPro.text = "Pro"
            } else {
                vLevel.lbPro.isHidden = true
                vLevel.lbPro.text = ""
            }
        }
    }
    
    @IBAction func tapFavouriteButton(_ sender: UIButton) {
        delegate?.removeFavourite(index: sender.tag)
    }
    
}
