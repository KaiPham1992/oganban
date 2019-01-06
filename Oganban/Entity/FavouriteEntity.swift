//
//  FavouriteEntity.swift
//  Oganban
//
//  Created by Admin on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class FavouriteEntity: BaseEntity {
    var id: String?
    var name: String?
    var createTime: Date?
    var level: String?
    var imgCropSrc: String?
    var pointRatingAvg: String?
    var isPro: String?
    var socialImage: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.name <- map["fullname"]
        self.createTime <- (map["create_time"], yyyyMMddHHmmssTransform())
        self.level <- map["level"]
        self.imgCropSrc <- map["crop_img_src"]
        self.pointRatingAvg <- map["point_rating_avg"]
        self.isPro <- map["is_pro"]
        self.socialImage <- map["social_img_src"]
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    init(_id: String, _name: String, _createTime: Date, _level: String, _imgCropSrc: String, _countRating: String, _isPro: String = "1") {
        super.init()
        self.id = _id
        self.name = _name
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

