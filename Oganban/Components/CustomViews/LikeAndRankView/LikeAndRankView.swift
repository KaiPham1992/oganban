//
//  LikeAndRankView.swift
//  RedStar
//
//  Created by Coby on 11/22/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit

protocol LikeAndRankViewDelegate: class {
    func btnLikeTapped()
}

class LikeAndRankView: BaseViewXib {
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lbLike: UILabel!
    @IBOutlet weak var imgRank: UIImageView!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var vRank: UIView!
    
    weak var delegate: LikeAndRankViewDelegate?
    
    override func setUpViews() {
        imgRank.image = AppImage.imgRank
    }
    
    func setRank(consultationStaff: ConsultationStaffEntity?) {
        switch consultationStaff?.rankName {
        case "Đồng":
            lbRank.text = RankState.bronze.rawValue
           lbRank.textColor = AppColor.green
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.green, cornerRadius: 5)
            imgRank.tintColor = AppColor.green
        case "Vàng":
            lbRank.text = RankState.gold.rawValue
            lbRank.textColor = AppColor.yellow
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.yellow, cornerRadius: 5)
            imgRank.tintColor = AppColor.yellow
        case "Bạch kim":
            lbRank.text = RankState.platinum.rawValue
            lbRank.textColor = AppColor.red
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.red, cornerRadius: 5)
            imgRank.tintColor = AppColor.red
        case "Kim cương":
            lbRank.text = RankState.diamon.rawValue
            lbRank.textColor = AppColor.orange
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.orange, cornerRadius: 5)
            imgRank.tintColor = AppColor.orange
        default:
            lbRank.text = RankState.silver.rawValue
            lbRank.textColor = .blue
            vRank.setBorder(borderWidth: 1, borderColor: .blue, cornerRadius: 5)
            
            imgRank.tintColor = .blue
        }
    }
    
    func setRank(consultationStaff: ConsultationStaffDetailEntity?) {
        switch consultationStaff?.rankName {
        case "Đồng":
            lbRank.text = RankState.bronze.rawValue
            lbRank.textColor = AppColor.green
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.green, cornerRadius: 5)
            imgRank.tintColor = AppColor.green
        case "Vàng":
            lbRank.text = RankState.gold.rawValue
            lbRank.textColor = AppColor.yellow
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.yellow, cornerRadius: 5)
            imgRank.tintColor = AppColor.yellow
        case "Bạch kim":
            lbRank.text = RankState.platinum.rawValue
            lbRank.textColor = AppColor.red
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.red, cornerRadius: 5)
            imgRank.tintColor = AppColor.red
        case "Kim cương":
            lbRank.text = RankState.diamon.rawValue
            lbRank.textColor = AppColor.orange
            vRank.setBorder(borderWidth: 1, borderColor: AppColor.orange, cornerRadius: 5)
            imgRank.tintColor = AppColor.orange
        default:
            lbRank.text = RankState.silver.rawValue
            lbRank.textColor = .blue
            vRank.setBorder(borderWidth: 1, borderColor: .blue, cornerRadius: 5)
            
            imgRank.tintColor = .blue
        }
    }
    
    @IBAction func btnLikeTapped() {
        delegate?.btnLikeTapped()
    }
}
