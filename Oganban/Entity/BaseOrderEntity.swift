//
//  BaseOrderEntity.swift
//  Oganban
//
//  Created by Coby on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseOrderEntity: Mappable {
    
    var countOrder: Int?
    var dataOrder: [OrderEntity] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.countOrder <- map["count_order"]
        self.dataOrder <- map["data_order"]
    }
}
