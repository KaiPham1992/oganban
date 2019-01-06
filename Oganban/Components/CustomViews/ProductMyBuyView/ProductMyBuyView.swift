//
//  ProductView.swift
//  Oganban
//
//  Created by Coby on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class ProductMyBuyView: BaseViewXib {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet weak var lbNote: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbAvgRating: UILabel!
    @IBOutlet weak var imgIconMoney: UIImageView!
    
    var isAllOrder: Bool = false {
        didSet {
            setStatusOrder()
        }
    }
    
    var order: OrderEntity? {
        didSet {
            guard let _order = order else  { return }
            lbProductName.text = _order.name
            lbTime.text = _order.createTimeMi?.timeAgo()
            
            lbName.text = _order.fullName
            lbRank.text = _order.level
            lbNote.isHidden = _order.isPro == "1" ? false : true
            lbStatus.text = _order.status
            lbAvgRating.text = _order.avgRating
            
            if _order.paymentType == "cash" {
                lbPrice.text = _order.showMoney()
                lbPrice.textColor = AppColor.red_233_1_1
                imgIconMoney.image = UIImage(named: "ic_money")
            } else {
                lbPrice.text = _order.showCoin()
                lbPrice.textColor = AppColor.green
                imgIconMoney.image = UIImage(named: "ic_coin")
            }
            
            
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_order.imgSrc ?? "")") {
                imgProduct.sd_setImage(with: url, placeholderImage: AppImage.imgLogo)
            }
            
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_order.imgSrcAccount ?? "")") {
                imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgLogo)
            }

        }
    }
    
    override func setUpViews() {
        imgAvatar.setBorderWithCornerRadius()
        lbStatus.isHidden = true
        lbPrice.underlineLastCharacter()
        setStatusOrder()
    }
    
    func setStatusOrder() {
        if isAllOrder {
            lbStatus.isHidden = false
            if let status = order?.getStatus() {
                switch status {
                case .new:
                    lbStatus.text = "Chờ duyệt"
                    lbStatus.backgroundColor = AppColor.yellow_228_251_30
                    lbStatus.textColor = AppColor.red_233_1_1
                case .waitDelivery:
                    lbStatus.text = "Đang giao"
                    lbStatus.backgroundColor = AppColor.yellow_228_251_30
                    lbStatus.textColor = AppColor.red_233_1_1
                case .done:
                    lbStatus.text = "Hoàn tất"
                    lbStatus.backgroundColor = AppColor.green005800
                    lbStatus.textColor = AppColor.yellow_245_255_0
                case .cancel:
                    lbStatus.text = "Đã huỷ "
                    lbStatus.backgroundColor = AppColor.gray_233_233_234
                    lbStatus.textColor = AppColor.gray_65_65_65
                default:
                    break
                }
            }
        } else {
            lbStatus.isHidden = true
        }
    }
}
