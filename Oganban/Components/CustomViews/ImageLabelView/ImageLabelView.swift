//
//  ImageLabelView.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/18/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class ImageLabelView: BaseViewXib {
    @IBOutlet weak var lbTitle: AppLabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    func setImage(image: UIImage) {
        imgIcon.image = image
    }
    
    override func setUpViews() {
        super.setUpViews()
        lbTitle.adjustsFontSizeToFitWidth = false
        lbTitle.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
}
