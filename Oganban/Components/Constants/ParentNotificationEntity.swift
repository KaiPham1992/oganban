//
//  ParentNotificationEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import ObjectMapper

class ParentNotificationEntity: BaseEntity {
    var totalUnread: Int?
    var notifications = [NotificationEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.totalUnread <- map["total_unread"]
        self.notifications <- map["data_notification"]
    }
}
