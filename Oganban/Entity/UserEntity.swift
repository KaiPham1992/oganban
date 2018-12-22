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
    var birthday: String?
    var gender: String?
    var imgSRC: String?
    var jwt: String?
    var codeVerify: String?
    var point2rank: String?
    var rankName: String?
    var rankKey: String?
    
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
    }
}
