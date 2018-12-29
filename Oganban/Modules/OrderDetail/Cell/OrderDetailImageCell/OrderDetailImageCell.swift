//
//  OrderDetailImageCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class OrderDetailImageCell: BaseTableCell {
    
    @IBOutlet weak var imageSlide: AppImageSlide!
    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var radioMoney: AppRadioButton!
    @IBOutlet weak var radioCoin: AppRadioButton!
    @IBOutlet weak var vMoneyCoin: UIStackView!
    @IBOutlet weak var heightMoneyCoin: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnHide.setAttributed(title: "Ẩn bài đăng", color: AppColor.gray_158_158_158, font: AppFont.fontRegular13, isUnderLine: true)
        btnCancel.setAttributed(title: "Huỷ giao dịch", color: AppColor.gray_158_158_158, font: AppFont.fontRegular13, isUnderLine: true)
        
        radioMoney.setMoney(money: 2000000)
        radioCoin.setOCoin(coin: 1999.09)
        // test fix me
        imageSlide.listItem = [
            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg")
        ]
    }
    
    func hideMoneyCoin() {
        heightMoneyCoin.constant = 0 // 0 25 50 
    }
    
}
