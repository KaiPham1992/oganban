//
//  OrderEntity.swift
//  Oganban
//
//  Created by Coby on 1/3/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct OrderEntity: Mappable {
    
    var id: String?
    var status: String?
    var paymentType: String?
    var totalPrice: String?
    var salePrice: String?
    var quantity: String?
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
    var totalCoin: String?
    var coin: String?
    
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
    }
}
