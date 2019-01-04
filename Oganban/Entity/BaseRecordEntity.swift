//
//  BaseRecordEntity.swift
//  Oganban
//
//  Created by Coby on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseRecordEntity: Mappable {
    
    var countExpired: Int?
    var countHide: Int?
    var allowNews: Int?
    var allowShow: Int?
    var dataRecord: [RecordEntity] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.countExpired <- map["count_expired"]
        self.countHide <- map["count_hide"]
        self.allowNews <- map["allow_news"]
        self.allowShow <- map["count_show"]
        self.dataRecord <- map["data_record"]
    }
}
