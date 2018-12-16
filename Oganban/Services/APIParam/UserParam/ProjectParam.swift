//
//  ProjectParam.swift
//  RedStar
//
//  Created by Coby on 11/24/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import ObjectMapper

class ProjectParam: BaseParam {
    var lat: String?
    var long: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.lat <- map["lat"]
        self.long <- map["long"]
    }
    
    init(lat: String?, long: String?) {
        super.init()
        self.lat = lat
        self.long = long
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
