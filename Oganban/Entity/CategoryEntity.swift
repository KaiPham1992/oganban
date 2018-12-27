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

struct CategoryMergeEntity: Mappable {
    
    var id: String?
    var name: String?
    var key: String?
    var isSelected = false
    var cateChild: [CategoryEntity] = []
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.name <- map["name"]
        self.key <- map["key"]
        self.cateChild <- map["cate_child"]
    }
}

class Menu {
    var parentCategory: CategoryEntity
    var listChild: [CategoryEntity]
    init(parent: CategoryEntity, listChild: [CategoryEntity]) {
        self.parentCategory = parent
        self.listChild = listChild
    }
    
    init(parent: CategoryEntity) {
        self.parentCategory = parent
        self.listChild = []
    }
}

class Scale {
    var title: String?
    var distance: String?
    
    init(title: String, distance: String?) {
        self.title = title
        self.distance = distance
    }
}
