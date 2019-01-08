//
//  HeaderOrderDetail.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderOrderBuyDetailDelegate: class {
    func addFavorite(isFavorite: Bool)
}

class HeaderOrderBuyDetail: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    var isLiked: Bool = false
    
    weak var delegate: HeaderOrderBuyDetailDelegate?
    
    override func setUpViews() {
        btnLike.isHidden = true
        btnLike.setImage(AppImage.imgUnLike, for: .normal)
        btnLike.tintColor = AppColor.gray_158_158_158
    }

    @IBAction func btnLikeTapped() {
        isLiked = !isLiked
        if isLiked {
            btnLike.setImage(AppImage.imgLike, for: .normal)
            delegate?.addFavorite(isFavorite: true)
        } else {
            btnLike.setImage(AppImage.imgUnLike, for: .normal)
            btnLike.tintColor = AppColor.gray_65_65_65
            delegate?.addFavorite(isFavorite: false)
        }
    }
}
