//
//  UpdateProfileParam.swift
//  Oganban
//
//  Created by Kent on 1/21/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class UpdateProfileParam: BaseParam {
    
    var birthday        : String?
    var fullName        : String?
    var gender          : String?
    var houseAddress    : String?
    var companyAddress  : String?
    var phone           : String?
    var phoneCode       : String?
    
    var long1           : String?
    var lat1            : String?
    
    var long2           : String?
    var lat2            : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.phone          <- map["phone"]
        self.phoneCode      <- map["phone_code"]
        self.birthday       <- map["birthday"]
        self.fullName       <- map["fullname"]
        self.gender         <- map["gender"]
        self.houseAddress   <- map["address_1"]
        self.companyAddress <- map["address_2"]
        self.lat2           <- map["latitude_2"]
        self.long2          <- map["longitude_2"]
        self.lat1           <- map["latitude_1"]
        self.long1          <- map["longitude_1"]
        
    }
    
    init(
         phoneNumber: String,phoneCode: String,
         birthday   : String?,
         fullName   : String?,
         gender     : String? = nil,
         houseAddress   : String? = nil,
         companyAddress   : String? = nil,
         lat1       : String? = nil,
         long1      : String? = nil,
         lat2       : String? = nil,
         long2      : String? = nil) {
        super.init()

        self.birthday       = birthday
        self.fullName       = fullName
        self.gender         = gender
        self.phone          = phoneNumber
        self.phoneCode      = phoneCode
        self.houseAddress   = houseAddress
        self.companyAddress = companyAddress
        self.lat2           = lat2
        self.long2          = long2
        self.lat1           = lat1
        self.long1          = long1
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

