//
//  OrderEntity.swift
//  Oganban
//
//  Created by Coby on 1/3/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

enum OrderStatusType: String {
    case new = "Đơn hàng chờ duyệt"
    case waitDelivery = "Đơn hàng đang giao"
    case done = "Đơn hàng hoàn tất"
    case cancel = "Đơn hàng đã huỷ"
}

enum OrderStatusKey: String {
    case new = "new"
    case waitDelivery = "wait_delivery"
    case cancel = "cancel"
    case done = "done"
}


struct OrderEntity: Mappable {
    
    var id: String?
    var status: String?
    var paymentType: String?
    var totalPrice: Double?
    var salePrice: Double?
    var quantity: Int?
    var accountID: String?
    var fullName: String?
    var imgSrcAccount: String?
    var cropImgSrcAccount: String?
    var isPro: String?
    var recordID: String?
    var name: String?
    var createTimeMi: Date?
    var totalRating: String?
    var avgRating: String?
    var level: String?
    var imgSrc: String?
    var totalCoin: Double?
    var coin: Int?
    
    var arrayImgSrc = [String]()
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.status <- map["status"]
        self.paymentType <- map["payment_type"]
        self.totalPrice <- map["total_price"]
        self.salePrice <- map["sale_price"]
        self.quantity <- map["quantity"]
        self.accountID <- map["account_id"]
        self.fullName <- map["fullname"]
        self.imgSrcAccount <- map["img_src_account"]
        self.cropImgSrcAccount <- map["crop_img_src_account"]
        self.isPro <- map["is_pro"]
        self.recordID <- map["record_id"]
        self.name <- map["name"]
        self.createTimeMi <- (map["create_time_mi"], AppTimestampTransform())
        self.totalRating <- map["total_rating"]
        self.avgRating <- map["avg_rating"]
        self.level <- map["level"]
        self.imgSrc <- map["img_src"]
        self.totalCoin <- map["total_coin"]
        self.coin <- map["coin"]
        
        self.arrayImgSrc <- map["img_src"]
    }
    
    func getStatus() -> OrderStatusType {
        switch self.status& {
        case OrderStatusKey.new.rawValue:
            return .new
        case OrderStatusKey.waitDelivery.rawValue:
            return .waitDelivery
        case OrderStatusKey.done.rawValue:
            return .done
        case OrderStatusKey.cancel.rawValue:
            return .cancel
        default:
            return .new
        }
    }
    
    var urlAvatar: URL? {
        //
        return URL(string: "\(BASE_URL)\(self.cropImgSrcAccount&)")
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
}
