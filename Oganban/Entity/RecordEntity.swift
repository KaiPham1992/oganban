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
    var imgSrc: String?
    var arrayImage = [String]()
    var imgHome: String?
    var level: String?
    var distanceConvert: String?
    var about: String?
    var address1: String?
    var address: String?
    var address2: String?
    var phone: String?
    var accountCoin: Double?
    
    var quantity: Int?
    var expiredDate: Date?
    var isActive: String?
    var cropImage: String?
    
    var status: String?
    var isTransaction: Bool?
    var isFavorite: Int?
    var categoryName: String?
    var catrgotyID: String?
    var isService: String?
    
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
        self.arrayImage <- map["img_src_list"]
        self.imgHome <- map["img_src"]
        self.address1 <- map["address_1"]
        self.address <- map["address"]
        self.address2 <- map["address_2"]
        self.level <- map["level"]
        self.phone <- map["phone"]
        self.cropImage <- map["crop_img_src_account"]
        self.accountCoin <- map["account_coin"]
        self.categoryName <- map["category_name"]
        self.catrgotyID <- map["category_id"]
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
        self.status <- map["status"]
        self.isTransaction <- map["is_transaction"]
        self.isFavorite <- map["is_favorite"]
        self.isService <- map["is_service"]
    }
    
    var ratingFormat: String? {
        if let rating = Double(self.avgRating&) {
            return rating.roundedOneDemical()
        } else {
            return ""
        }
    }
    
    var urlAvatar: URL? {
        //
        return URL(string: "\(BASE_URL)\(self.cropImage&)")
    }
    
    func showMoney() -> String? {
        return self.price?.toUInt64().toCurrency
    }
    
    func showMoneyHome() -> String? {
        if let _price = self.price {
            return "\(String(describing: _price.formattedWithSeparator)) đ"
        }
        
        return nil
    }
    
    func showCoin() -> String? {
        if let _coin = self.coin {
            return "\(String(describing: _coin.toCurrency)) ơ"
        }
        
        return nil
    }
}
