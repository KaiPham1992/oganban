//
//  OrderDetailImageCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit


class OrderBuyDetailImageCell: BaseTableCell {
    
    @IBOutlet weak var imageSlide: AppImageSlide!
    @IBOutlet weak var radioMoney: AppRadioButton!
    @IBOutlet weak var radioCoin: AppRadioButton!
    @IBOutlet weak var vMoneyCoin: UIStackView!
    @IBOutlet weak var heightMoneyCoin: NSLayoutConstraint!
    
    @IBOutlet weak var lbNameRecord: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    
    
    // My sell
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            
            //--
            imageSlide.listItem = _record.arrayImage
            lbNameRecord.text = _record.name
            if _record.expiredDate == nil {
                lbExpireDate.text = Date().toString(dateFormat: AppDateFormat.ddMMYYYY_VN)
            } else {
                lbExpireDate.text = _record.expiredDate?.toString(dateFormat: AppDateFormat.ddMMYYYY_VN)
            }
            
            lbQuantity.text = "Số lượng: \(_record.quantity&)"
            
            if let price = _record.price {
                 radioMoney.setMoney(money: price)
            }
            
            radioCoin.setOCoin(coin: _record.coin)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        radioMoney.delegate = self
        radioCoin.delegate = self
       
    }
    
    func hideMoneyCoin() {
        heightMoneyCoin.constant = 0 // 0 25 50 
    }
    
}
extension OrderBuyDetailImageCell: AppRadioButtonDelegate {
    func changedSelected(sender: AppRadioButton, isSelected: Bool) {
        if radioCoin ==  sender {
            radioCoin.isChecked = true
            radioMoney.isChecked = false
        } else {
            radioMoney.isChecked = true
            radioCoin.isChecked = false
        }
    }
    
}
