//
//  OrderDetailImageCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

protocol OrderDetailImageCellDelegate: class {
    func btnHideTapped()
    func btnDeleteTapped()
}

class OrderDetailImageCell: BaseTableCell {
    
    @IBOutlet weak var imageSlide: AppImageSlide!
    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var radioMoney: AppRadioButton!
    @IBOutlet weak var radioCoin: AppRadioButton!
    @IBOutlet weak var vMoneyCoin: UIStackView!
    @IBOutlet weak var heightMoneyCoin: NSLayoutConstraint!
    
    @IBOutlet weak var lbNameRecord: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    
    var isMySellHide: Bool = false
    var isMySellExpired: Bool = false
    
    var isToOrderSellDetail: Bool = false
    
    // My sell
    var record: RecordEntity? {
        didSet {
            guard let _record = record else { return }
            setDefautlMySell()
            
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
    
    weak var delegate: OrderDetailImageCellDelegate?
    
    private func setDefautlMySell() {
        radioMoney.setMoney(money: 0)
        radioCoin.setOCoin(coin: 0)
        
        radioMoney.setOneImage(image: AppImage.imgMoney)
        radioCoin.setOneImage(image: AppImage.imgCoin)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnHide.setAttributed(title: "Ẩn bài đăng", color: AppColor.gray_158_158_158, font: AppFont.fontRegular13, isUnderLine: true)
        btnCancel.setAttributed(title: "Huỷ giao dịch", color: AppColor.gray_158_158_158, font: AppFont.fontRegular13, isUnderLine: true)
        btnCancel.isHidden = true
       
        // test fix me
//        imageSlide.listItem = [
//            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
//            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
//            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
//            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg"),
//            BannerEntity(url: "http://file.vforum.vn/hinh/2015/09/vforum-bo-hinh-nen-phong-canh-thien-nhien-dep-nhat-16.jpg")
//        ]
    }
    
    func hideMoneyCoin() {
        heightMoneyCoin.constant = 0 // 0 25 50 
    }
    
    @IBAction func btnHideTapped() {
        if isMySellHide {
            delegate?.btnDeleteTapped()
        } else {
            delegate?.btnHideTapped()
        }
    }
    
}
