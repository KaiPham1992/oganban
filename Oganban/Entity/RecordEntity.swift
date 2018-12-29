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
    var price: Double?
    var coin: Double?
    var isNew: String?
    var isPro: String?
    var long: String?
    var lat: String?
    var accountId: String?
    var fullName: String?
    var totalRating: String?
    var avgRating: String?
    var imgSrcAccount: String?
    var createTime: Date?
    var distance: String?
    var imgSrc = [String]()
    var level: String?
    var distanceConvert: String?
    var about: String?
    var address1: String?
    var address2: String?
    var phone: String?
    
    var quantity: Double?
    var expiredDate: Date?
    var isActive: String?
    var cropImage: String?
    
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
        self.createTime <- (map["create_time_mi"], AppTimestampTransform())
        self.distance <- map["distance"]
        self.imgSrc <- map["img_src"]
        self.address1 <- map["address_1"]
        self.address2 <- map["address_2"]
        self.level <- map["level"]
        self.phone <- map["phone"]
        self.cropImage <- map["crop_img_src_account"]
        
        if let distance = self.distance, let dis = Double(distance) {
            let temp = dis * 1000
            if temp > 1000 {
                distanceConvert = "\(Int(temp/1000))km"
            } else {
                distanceConvert = "\(Int(temp))m"
            }
        }
        
        self.quantity <- map["quantity"]
        self.expiredDate <- (map["expired_date"],yyyyMMddHHmmssTransform())
        self.isActive <- map["is_active"]
        self.about <- map["about_record"]
    }
    
    var urlAvatar: URL? {
        return URL(string: "\(BASE_URL)\(self.cropImage&)")
    }
}
