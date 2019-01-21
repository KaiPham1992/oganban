//
//  AppRatingView.swift
//  Oganban
//
//  Created by Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class AppRatingView: BaseViewXib {
    var number: Int = 1
    @IBOutlet weak var vStackView: UIStackView!
    
    @IBAction func btnActionTapped(sender: UIButton) {
        number = sender.tag
        setStar(number: number)
    }
    
    override func setUpViews() {
        setStar(number: number)
    }
    
    func setStar(number: Int) {
        self.number = number
        for subView  in vStackView.arrangedSubviews {
            if let btn = subView as? UIButton {
                if btn.tag <= number {
                    btn.setImage(AppImage.imgStarYellow, for: .normal)
                } else {
                    btn.setImage(AppImage.imgStarEmpty, for: .normal)
                }
            }
        }
    }
    
}
