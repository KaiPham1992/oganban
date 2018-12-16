//
//  ConsultationStaffParam.swift
//  RedStar
//
//  Created by Coby on 11/21/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import ObjectMapper
class ConsultationStaffParam: BaseParam {
    var id: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["_id"]
    }
    
    init(id: String?) {
        super.init()
        self.id = id
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
