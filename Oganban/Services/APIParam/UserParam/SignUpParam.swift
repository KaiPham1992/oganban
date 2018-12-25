//
//  SignUpParam.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/25/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class SignUpParam: BaseParam {
    var email           : String?
    var password        : String?
    var birthday        : String?
    var captcha         : String?
    var fullName        : String?
    var codeIntroduce   : String?
    var gender          : String?
    var address1        : String?
    var address2        : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.email          <- map["email"]
        self.password       <- map["password"]
        self.birthday       <- map["birthday"]
        self.captcha        <- map["captcha"]
        self.fullName       <- map["fullname"]
        self.codeIntroduce  <- map["code_introduction"]
        self.gender         <- map["gender"]
        self.address1       <- map["address_1"]
        self.address2       <- map["address_2"]
    }
    
    init(email      : String?,
         password   : String?,
         birthday   : String?,
         captcha    : String?,
         fullName   : String? = nil,
         gender     : String? = nil,
         address1   : String? = nil,
         address2   : String? = nil,
         codeIntroduce: String? = nil) {
        super.init()
        self.email          = email
        self.password       = password
        self.birthday       = birthday
        self.captcha        = captcha
        self.fullName       = fullName
        self.codeIntroduce  = codeIntroduce
        self.gender         = gender
        self.address1       = address1
        self.address2       = address2
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

