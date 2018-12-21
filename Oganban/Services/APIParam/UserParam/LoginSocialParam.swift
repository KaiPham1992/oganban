//
//  LoginSocialParam.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

import UIKit
import ObjectMapper

enum SocialType: String {
    case faceBook = "facebook"
    case gmail = "gmail"
}

class LoginSocialParam: BaseParam {
    var firebaseToken: String?
    var email: String?
    var phoneCode: String?
    var phoneNumber: String?
    var timeZone: String?
    var fullName: String?
    var socialImage: String?
    var socialType: String?
    var socialId: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.firebaseToken <- map["firebase_token"]
        self.email <- map["email"]
        self.phoneCode <- map["phone_code"]
        self.phoneNumber <- map["phone_number"]
        self.timeZone <- map["timezone"]
        self.fullName <- map["fullname"]
        self.socialImage <- map["social_img_src"]
        self.socialType <- map["social_type"]
        self.socialId <- map["social_id"]
    }
    
    init(socialId: String?, email: String?, phoneNumber: String?, fullName: String?, socialImage: String?, socialType: String?) {
        super.init()
        if let fcmToken = UserDefaultHelper.shared.fcmToken {
            self.firebaseToken = fcmToken
        }
        
        self.email = email
        self.phoneCode = "VN"
        self.phoneNumber = phoneNumber
        self.timeZone = Utils.getTimeZone()
        self.fullName = fullName
        self.socialImage = socialImage
        self.socialType = socialType
        self.socialId = socialId
    }
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    }
}
