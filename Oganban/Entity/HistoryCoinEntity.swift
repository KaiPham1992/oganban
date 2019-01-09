//
//  HistoryCoinEntity.swift
//  Oganban
//
//  Created by Kent on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class HistoryCoinEntity: BaseEntity {
    var id: String?
    var content: String?
    var createTime: Date?
    var coin: Double?
    var type: String?
   
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["order_id"]
        self.content <- map["description"]
        self.createTime <- (map["create_time_mi"], AppTimestampTransform())
        self.coin <- map["coin"]
        self.type <- map["type"]
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    init(_id: String, _content: String, _createTime: Date, _coin: Double) {
        super.init()
        self.id = _id
        self.content = _content
        self.createTime = _createTime
        self.coin = _coin
    }
}
