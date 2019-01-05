//
//  ExpirePostEntity.swift
//  Oganban
//
//  Created by Kai Pham on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class ExpirePostEntity: BaseEntity {
    var expiredDate: Date?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.expiredDate <- (map["expired_date"],yyyyMMddHHmmssTransform())
    }
}
