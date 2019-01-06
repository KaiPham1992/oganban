//
//  OrderDetailEntity.swift
//  Oganban
//
//  Created by Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class OrderDetailEntity: BaseEntity {
    
    var orderId: String?
    var status: String?
    var paymentType: String?
    var totalPrice: Double?
    var totalCoin: Double?
    var salePrice: Double?
    var quantity: Int?
    var recordId: String?
    var name: String?
    var arrayImage = [String]()
    var creatTime: Date?
    
    // saler
    var accountIDSaler: String?
    var fullNameSaler: String?
    var countCoinSaler: Double?
    var isProSaler: String?
    var phoneSaler: String?
    var codePhoneSaler: String?
    var totalRatingSaler: String?
    var avgRatingSaler: String?
    var imgSrcSaler: String?
    var imgCropSaler: String?
    var levelSaler: String?
    
    // buyer
    var accountIDBuyer: String?
    var fullNameBuyer: String?
    var countCoinBuyer: Double?
    var isProBuyer: String?
    var phoneBuyer: String?
    var codePhoneBuyer: String?
    var totalRatingBuyer: String?
    var avgRatingBuyer: String?
    var imgSrcBuyer: String?
    var imgCropBuyer: String?
    var levelBuyer: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.orderId <- map["_id"]
        self.status <- map["status"]
        self.paymentType <- map["payment_type"]
        self.totalPrice <- map["total_price"]
        self.totalCoin <- map["total_coin"]
        self.salePrice <- map["sale_price"]
        self.quantity <- map["quantity"]
        self.name <- map["name"]
        self.arrayImage <- map["img_src"]
        self.recordId <- map["record_id"]
        self.creatTime <- (map["create_time_mi"], AppTimestampTransform())
        
        // saler
        self.accountIDSaler <- map["account_id_saler"]
        self.fullNameSaler <- map["fullname_seller"]
        self.countCoinSaler <- map["account_coin_saler"]
        self.isProSaler <- map["is_pro_seller"]
        self.phoneSaler <- map["phone_seller"]
        self.codePhoneSaler <- map["phone_code_seller"]
        self.totalRatingSaler <- map["total_rating_seller"]
        self.avgRatingSaler <- map["avg_rating_seller"]
        self.imgSrcSaler <- map["img_src_seller"]
        self.imgCropSaler <- map["crop_img_src_seller"]
        self.levelSaler <- map["level_seller"]
        
        // buyer
        self.accountIDBuyer <- map["account_id_buyer"]
        self.fullNameBuyer <- map["fullname_buyer"]
        self.countCoinBuyer <- map["account_coin_buyer"]
        self.isProBuyer <- map["is_pro_buyer"]
        self.phoneBuyer <- map["phone_buyer"]
        self.codePhoneBuyer <- map["phone_code_buyer"]
        self.totalRatingBuyer <- map["total_rating_buyer"]
        self.avgRatingBuyer <- map["avg_rating_buyer"]
        self.imgSrcBuyer <- map["img_src_buyer"]
        self.imgCropBuyer <- map["crop_img_src_buyer"]
        self.levelBuyer <- map["level_buyer"]
        
    }
    
    func isBuyer() -> Bool {
        return self.accountIDBuyer == UserDefaultHelper.shared.loginUserInfo?.id
    }
    
    func getStatus() -> OrderStatusType {
        switch self.status& {
        case OrderStatusKey.new.rawValue:
            return .new
        case OrderStatusKey.waitDelivery.rawValue:
            return .waitDelivery
        case OrderStatusKey.done.rawValue:
            return .done
        case OrderStatusKey.cancel.rawValue, OrderStatusKey.buyerCancel.rawValue, OrderStatusKey.sellerCancel.rawValue:
            return .cancel
        default:
            return .orderNotYetArrived
        }
    }
    
    var urlAvatarBuyer: URL? {
        return URL(string: "\(BASE_URL)\(self.imgCropBuyer&)")
    }
    
    var urlAvatarSaler: URL? {
        return URL(string: "\(BASE_URL)\(self.imgCropSaler&)")
    }
    
    func showMoney() -> String? {
        return self.totalPrice?.toUInt64().toCurrency
    }
    
    func showCoin() -> String? {
        if let _coin = self.totalCoin {
            return "\(String(describing: _coin.toCurrency)) ơ"
        }
        
        return nil
    }
    
    func showFullPhoneBuyer() -> String? {
        return "\(self.codePhoneBuyer&)\(self.phoneBuyer&)"
    }
    
    func showFullPhoneSaler() -> String? {
        return "\(self.codePhoneSaler&)\(self.phoneSaler&)"
    }
    
    func showTotolRatingBuyer() -> String? {
        return self.totalRatingBuyer& + " đánh giá"
    }
    
    func showTotolRatingSaler() -> String? {
        return self.totalRatingSaler& + " đánh giá"
    }
}
