//
//  HistoryBuyEntity.swift
//  Oganban
//
//  Created by Kent on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class HistoryBuyEntity: BaseEntity {
    var id: String?
    var content: String?
    var createTime: Date?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.content <- map["content"]
        self.createTime <- (map["create_time"], yyyyMMddHHmmssTransform())
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    init(_id: String, _content: String, _createTime: Date) {
        super.init()
        self.id = _id
        self.content = _content
        self.createTime = _createTime
    }
}
