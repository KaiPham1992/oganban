//
//  FavouriteEntity.swift
//  Oganban
//
//  Created by Kent on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class FavouriteEntity: BaseEntity {
    
    var createTime: Date?
    var id: String?
    var fullName: String?
    var imgCropSrc: String?
    var imgSrc: String?
    var coin: Double?
    var isPro: String?
    var pointRatingAvg: String?
    var level: String?
    var totalRating: String?
    var socialImage: String?

    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.createTime <- (map["create_time_mi"], AppTimestampTransform())
        self.id <- map["account_id"]
        self.fullName <- map["fullname"]
        self.imgCropSrc <- map["crop_img_src"]
        self.imgSrc <- map["img_src"]
        self.coin <- map["coin"]
        self.isPro <- map["is_pro"]
        self.pointRatingAvg <- map["point_rating_avg"]
        self.level <- map["level"]
        self.totalRating <- map["count_rating"]
        self.socialImage <- map["social_img_src"]
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    init(_id: String, _name: String, _createTime: Date, _level: String, _imgCropSrc: String, _countRating: String, _isPro: String = "1") {
        super.init()
        self.id = _id
        self.fullName = _name
        self.createTime = _createTime
        self.level = _level
        self.imgCropSrc = _imgCropSrc
        self.pointRatingAvg = _countRating
        self.isPro = _isPro
    }
    
    var urlAvatar:  URL? {
        if let urlString = self.imgCropSrc, let url = URL(string: BASE_URL_IMAGE + urlString) {
            return url
            
        } else if let urlString = socialImage, let url = URL(string: urlString) {
            return url
        }
        
        return nil
    }
}

