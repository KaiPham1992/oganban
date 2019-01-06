//
//  UserEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserEntity: Mappable, Codable {
    
    var id: String?
    var userName: String?
    var email: String?
    var fullName: String?
    var phone: String?
    var phoneCode: String?
    var birthday: String?
    var gender: String?
    var imgSRC: String?
    var jwt: String?
    var codeVerify: String?
    var point2rank: String?
    var rankName: String?
    var rankKey: String?
    var houseAddress: String?
    var companyAddress: String?
    var isLoggedSocial: String?
    var imgCropSrc: String?
    var codeIntro: String?
    var pointRatingAvg: String?
    var countRating: String?
    var level: String?
    var languageCode: String?
    var isVerified: String?
    var socialImage: String?
    var isPro: String?
    var coin: Double?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.userName <- map["username"]
        self.email <- map["email"]
        self.fullName <- map["fullname"]
        self.phone <- map["phone"]
        self.phoneCode <- map["phone_code"]
        self.birthday <- map["birthday"]
        self.gender <- map["gender"]
        self.imgSRC <- map["img_src"]
        self.imgCropSrc <- map["crop_img_src"]
        self.codeIntro <- map["code_intro"]
        self.pointRatingAvg <- map["point_rating_avg"]
        self.countRating <- map["count_rating"]
        self.level <- map["level"]
        self.languageCode <- map["language_code"]
        self.isVerified <- map["is_verified"]
        self.jwt <- map["jwt"]
        self.codeVerify <- map["code_verify"]
        self.point2rank <- map["point2rank"]
        self.rankName <- map["rank_name"]
        self.rankKey <- map["rank_key"]
        self.houseAddress <- map["address_1"]
        self.companyAddress <- map["address_2"]
        self.phoneCode <- map["phone_code"]
        self.isLoggedSocial <- map["is_logged_social"]
        self.socialImage <- map["social_img_src"]
        self.isPro <- map["is_pro"]
        self.coin <- map["coin"]
    }
    
    init (displayName: String, phoneNumber: String,phoneCode: String, birthday: String,gender: String?, houseAddress: String?, companyAddress: String?) {
        self.fullName = displayName
        self.phone = phoneNumber
        self.phoneCode = phoneCode
        self.birthday = birthday
        self.gender = gender
        self.houseAddress = houseAddress
        self.companyAddress = companyAddress
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
