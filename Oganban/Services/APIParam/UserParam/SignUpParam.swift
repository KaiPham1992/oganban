//
//  SignUpParam.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/22/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import ObjectMapper

class SignUpParam: BaseParam {
    var email: String?
    var password: String?
    var userName: String?
    var captcha: String?
    var fullName: String?
    var codeReference: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.email <- map["email"]
        self.password <- map["password"]
        self.userName <- map["username"]
        self.captcha <- map["captcha"]
        self.fullName <- map["fullname"]
        self.codeReference <- map["code_introduction"]
    }
    
    init(email: String?, password: String?, name: String?, captcha: String?, fullName: String? = nil, phone: String? = nil, phoneCode: String? = nil, codeReference: String? = nil) {
        super.init()
        self.email = email
        self.password = password
        self.userName = name
        self.captcha = captcha
        self.fullName = fullName
        self.codeReference = codeReference
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
