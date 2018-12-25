//
//  UserEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserEntity: Mappable {
    
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
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.userName <- map["username"]
        self.email <- map["email"]
        self.fullName <- map["fullname"]
        self.phone <- map["phone"]
        self.birthday <- map["birthday"]
        self.gender <- map["gender"]
        self.imgSRC <- map["img_src"]
        self.jwt <- map["jwt"]
        self.codeVerify <- map["code_verify"]
        self.point2rank <- map["point2rank"]
        self.rankName <- map["rank_name"]
        self.rankKey <- map["rank_key"]
        self.houseAddress <- map["address_1"]
        self.companyAddress <- map["address_2"]
        self.phoneCode <- map["phone_code"]
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
}
