//
//  UpdateProfileParam.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/22/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import ObjectMapper

class UpdateProfileParam: BaseParam {
    var email: String?
    var fullName: String?
    var phone: String?
    var phoneCode: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.email <- map["email"]
        self.fullName <- map["fullname"]
        self.phone <- map["phone_number"]
        self.phoneCode <- map["phone_code"]
    }
    
    init(email: String?, fullName: String?, phone: String?, code: String?) {
        super.init()
        self.email = email
        self.fullName = fullName
        self.phone = phone
        self.phoneCode = code
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

