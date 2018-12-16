//
//  RatingUserParam.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/10/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import ObjectMapper

class RatingUserParam: BaseParam {
    var accountId: String?
    var medalKey: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.accountId <- map["executor_id"]
        self.medalKey <- map["medal_key"]
    }
    
    init(accountId: String?, medalKey: String?) {
        super.init()
        self.accountId = accountId
        self.medalKey = medalKey
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
