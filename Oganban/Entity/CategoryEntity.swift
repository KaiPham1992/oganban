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
    var isServiceString: String?
    var isService: Bool?
    var isSelected = false
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.name <- map["name"]
        self.key <- map["key"]
        self.isServiceString <- map["is_service"]
        
        if let service = isServiceString {
            isService = service == "1" ? true : false
        }
    }
}

struct CategoryMergeEntity: Mappable {
    
    var id: String?
    var name: String?
    var key: String?
    var isSelected = false
    var isServiceString: String?
    var isService: Bool?
    var cateChild: [CategoryEntity] = []
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.name <- map["name"]
        self.key <- map["key"]
        self.cateChild <- map["cate_child"]
        self.isServiceString <- map["is_service"]
        
        if let service = isServiceString {
            isService = service == "1" ? true : false
        }
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

struct PositionRangeEntity: Mappable, Codable {
    
    var id: String?
    var value: String?
    var title: String?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        self.id <- map["_id"]
        self.value <- map["_value"]
        
        if let _value = Int(value&) {
            if _value < 1000 {
                self.title = "\(value&)m"
            } else {
                self.title = "\(_value/1000)km"
            }
        } else {
            self.title = "Không giới hạn"
        }
    }
}

