//
//  OrderDetailImageCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

protocol MyBuyImageCellDelegate: class {
    func btnCancelTapped()
}

class MyBuyImageCell: BaseTableCell {
    
    @IBOutlet weak var imageSlide: AppImageSlide!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var radioMoney: AppRadioButton!
    @IBOutlet weak var radioCoin: AppRadioButton!
    @IBOutlet weak var vMoneyCoin: UIStackView!
    @IBOutlet weak var heightMoneyCoin: NSLayoutConstraint!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var lbQuantity: UILabel!
    
    weak var delegate: MyBuyImageCellDelegate?
    
    func setData(order: OrderDetailEntity?, isSaler: Bool) {
        guard let _order = order else { return }
        setDefautlMySell()
        if isSaler {
            btnCancel.isHidden = _order.getStatus() != .waitDelivery
        } else {
            if _order.getStatus() == .new || _order.getStatus() == .waitDelivery {
                btnCancel.isHidden = false
            } else {
                btnCancel.isHidden = true
            }
        }
        //--
        imageSlide.listItem = _order.arrayImage
        lbName.text = _order.name
        lbStatus.text = _order.getStatus().rawValue
        btnTime.setTitle(_order.updateTime?.timeAgo(), for: .normal)
        lbQuantity.text = "SL đặt mua: \(_order.quantity&)"
        
        if _order.paymentType == "cash" {
            radioMoney.setOneImage(image: AppImage.imgMoney)
            guard let price = _order.totalPrice, let quantity = _order.quantity else { return}
                radioMoney.setMoney(money: price)
            
            radioCoin.setOneImage(image: AppImage.imgMoneyTotal)
            radioCoin.setTotalMoney(money: price * Double(quantity))
        } else {
            radioMoney.setOneImage(image: AppImage.imgCoin)
            guard let coin = _order.totalCoin, let quantity = _order.quantity else { return}
            radioMoney.setOCoin(coin: coin)
            radioCoin.setOneImage(image: AppImage.imgCoin)
            radioCoin.setTotalOCoin(coin: coin * Double(quantity))
        }
    }
    
    private func setDefautlMySell() {
        radioMoney.setOneImage(image: AppImage.imgMoney)
        btnCancel.setAttributed(title: "Huỷ giao dịch", color: AppColor.gray_158_158_158, font: AppFont.fontRegular13, isUnderLine: true)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func hideMoneyCoin(isSeller: Bool) {
        if isSeller {
           heightMoneyCoin.constant = 25
        } else {
            heightMoneyCoin.constant = 50
        }
         // 0 25 50
    }
    
    @IBAction func btnCancelTapped() {
        delegate?.btnCancelTapped()
    }
}
