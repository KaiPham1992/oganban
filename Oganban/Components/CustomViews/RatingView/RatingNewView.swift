//
//  ARatingNewView.swift
//  AIAHealthCare
//
//  Created by Coby on 11/21/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import Foundation
import UIKit
class RatingNewView: UIView {
    
    var rateNum: Double? {
        didSet {
            if let num = rateNum {
                let imageNormal = AppImage.imgStarUnselected
                let imageSelected = AppImage.imgStarSelected
                let imageHalfSelected = AppImage.imgStarHalfSelectd
                let list = [imgStar1, imgStar2, imgStar3, imgStar4, imgStar5]
                
                if rint(num) == num {
                    for i in 0..<list.count {
                        if i < Int(num) {
                            list[i].image = imageSelected
                        } else {
                            list[i].image = imageNormal
                        }
                        
                    }
                } else {
                    for i in 0..<list.count {
                        if i + 1 == Int(num + 0.5) {
                            list[i].image = imageHalfSelected
                        } else if i < Int(num) {
                            list[i].image = imageSelected
                        } else {
                            list[i].image = imageNormal
                        }
                    }
                }
                
//                lbCount.text = "(\(num))"
            }
        }
    }
    
    
    let imgStar1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.imgStarUnselected
        return imageView
    }()
    
    let imgStar2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.imgStarUnselected
        return imageView
    }()
    
    let imgStar3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.imgStarUnselected
        return imageView
    }()
    
    let imgStar4: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.imgStarUnselected
        return imageView
    }()
    
    let imgStar5: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.imgStarUnselected
        return imageView
    }()
    
    let lbCount: UILabel = {
        let lb = UILabel()
        lb.textColor = AppColor.orangePeel
        lb.font =  AppFont.fontRegular15
        return lb
    }()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        //        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(imgStar1)
        addSubview(imgStar2)
        addSubview(imgStar3)
        addSubview(imgStar4)
        addSubview(imgStar5)
        
        addSubview(lbCount)
        imgStar1.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, widthConstant: self.frame.width / 5)
        imgStar2.anchor(self.topAnchor, left: imgStar1.rightAnchor, bottom: self.bottomAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, widthConstant: self.frame.width / 5)
        imgStar3.anchor(self.topAnchor, left: imgStar2.rightAnchor, bottom: self.bottomAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, widthConstant: self.frame.width / 5)
        imgStar4.anchor(self.topAnchor, left: imgStar3.rightAnchor, bottom: self.bottomAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, widthConstant: self.frame.width / 5)
        imgStar5.anchor(self.topAnchor, left: imgStar4.rightAnchor, bottom: self.bottomAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, widthConstant: self.frame.width / 5)
        
        
        lbCount.anchor(left: imgStar5.rightAnchor, leftConstant: 5)
        lbCount.centerYToView(view: imgStar1, constant: 0)
    }
}
