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
            btnCancel.isHidden = true
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
        btnTime.setTitle(_order.creatTime?.timeAgo(), for: .normal)
        lbQuantity.text = "SL đặt mua: \(_order.quantity&)"
        
        if _order.paymentType == "cash" {
            radioMoney.setOneImage(image: AppImage.imgMoney)
            if let price = _order.totalPrice {
                radioMoney.setMoney(money: price)
            }
        } else {
            radioMoney.setOneImage(image: AppImage.imgCoin)
            radioMoney.setOCoin(coin: _order.totalCoin)
        }
    }
    
    private func setDefautlMySell() {
        radioMoney.setOneImage(image: AppImage.imgMoney)
        btnCancel.setAttributed(title: "Huỷ giao dịch", color: AppColor.gray_158_158_158, font: AppFont.fontRegular13, isUnderLine: true)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func hideMoneyCoin() {
        heightMoneyCoin.constant = 0 // 0 25 50
    }
    
    @IBAction func btnCancelTapped() {
        delegate?.btnCancelTapped()
    }
}
