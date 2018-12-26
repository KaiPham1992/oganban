//
//  CategoryEntity.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct CategoryEntity: Mappable {
    
    var id: String?
    var name: String?
    var key: String?
    var isSelected = false
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.name <- map["name"]
        self.key <- map["key"]
    }
}
