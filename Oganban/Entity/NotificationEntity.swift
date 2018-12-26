//
//  Notification.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//


import ObjectMapper

class NotificationEntity: BaseEntity {
    var id: String?
    var title: String?
    var content: String?
    var isReadString: String?
    var isRead: Bool?
    var readTime: Date?
    var createTime: Date?
//    var timstamp: Unit64?
    
    //    {
    //        "_id": "292",
    //        "_title": "OGANBAN thông báo",
    //        "_content": "test mô tả",
    //        "action_key": "OTHER",
    //        "is_read": "1",
    //        "read_time": "2018-08-20 18:42:24",
    //        "create_time": "2018-08-18 13:40:32",
    //        "create_time_mi": "1534574432984"
    //    },
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.title <- map["_title"]
        self.content <- map["_content"]
        self.createTime <- (map["create_time"], yyyyMMddHHmmssTransform())
        self.readTime <- (map["read_time"], yyyyMMddHHmmssTransform())
        self.isRead <- map["is_read"]
        self.isReadString <- map["is_read"]
       self.isRead =  self.isReadString == "1"
    }
    
    required init?(map: Map) {
        super.init()
    }
}

