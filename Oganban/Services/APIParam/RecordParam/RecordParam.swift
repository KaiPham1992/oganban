//
//  RecordParam.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class RecordParam: BaseParam {
    var categoryId  : [String]?
    var long        : String?
    var lat         : String?
    var isSave      : String?
    var keyword      : String?
    var radius      : String?
    var offset      : Int?
    var limit       : Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.categoryId     <- map["category_id"]
        self.long           <- map["longitude"]
        self.lat            <- map["latitude"]
        self.isSave         <- map["is_save"]
        self.keyword        <- map["keyword"]
        self.radius         <- map["nearby_radius"]
        self.offset         <- map["offset"]
        self.limit          <- map["limit"]
    }
    
    init(id         : [String]? = nil,
         long       : String? = nil,
         lat        : String? = nil,
         isSave     : String? = nil,
         keyword    : String? = nil,
         radius     : String? = nil,
         offset     : Int? = 0,
         limit      : Int? = 50) {
        super.init()
        self.categoryId         = id
        self.long               = long
        self.lat                = lat
        self.isSave             = isSave
        self.keyword            = keyword
        self.radius             = radius
        self.offset             = offset
        self.limit              = limit
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

