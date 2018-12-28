//
//  RecordEntity.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class RecordEntity: BaseEntity {
    
    var id: String?
    var name: String?
    var price: String?
    var coin: String?
    var isNew: String?
    var isPro: String?
    var long: String?
    var lat: String?
    var accountId: String?
    var fullName: String?
    var totalRating: String?
    var avgRating: String?
    var imgSrcAccount: String?
    var createTime: String?
    var distance: String?
    var imgSrc: String?
    var level: String?
    
    required init?(map: Map) {
        super.init()
    }
   
    override func mapping(map: Map) {
        self.id <- map["_id"]
        self.name <- map["name"]
        self.price <- map["price"]
        self.coin <- map["coin"]
        self.isNew <- map["is_new"]
        self.isPro <- map["is_pro"]
        self.long <- map["longitude"]
        self.lat <- map["latitude"]
        self.accountId <- map["account_id"]
        self.fullName <- map["fullname"]
        self.totalRating <- map["total_rating"]
        self.avgRating <- map["avg_rating"]
        self.imgSrcAccount <- map["img_src_account"]
        self.createTime <- map["create_time_mi"]
        self.distance <- map["distance"]
        self.imgSrc <- map["img_src"]
        self.level <- map["level"]
        
    }
}
