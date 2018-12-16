//
//  AchievementView.swift
//  RedStar
//
//  Created by Coby on 11/22/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit

class AchievementView: BaseView {
    lazy var imgAchievement: UIImageView = {
        let img = UIImageView()
            img.image = AppImage.imgRank
            img.tintColor = .black
        return img
    }()
    
    lazy var lbTitle: UILabel = {
       let lb = UILabel()
        lb.text = "Tư vấn viên xuất sắc 10/2018"
        lb.font = AppFont.fontRegular13
        lb.numberOfLines = 2
        return lb
    }()
    
    override func setUpViews() {
        addSubview(imgAchievement)
        addSubview(lbTitle)
        
        imgAchievement.anchor(self.topAnchor, left: self.leftAnchor, topConstant: 0, leftConstant: 0, widthConstant: 15, heightConstant: 15)
        lbTitle.anchor(self.topAnchor, left: imgAchievement.rightAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 15, rightConstant: 15)
        
    }
}
