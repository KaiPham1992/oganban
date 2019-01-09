//
//  BaseHistoryCoinEntity.swift
//  Oganban
//
//  Created by Kent on 1/8/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseHistoryCoinEntity: Mappable {
    
    var accountCoin: Double?
    var dataCoin: [HistoryCoinEntity] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.accountCoin <- map["account_coin"]
        self.dataCoin <- map["data_coin"]
    }
}
