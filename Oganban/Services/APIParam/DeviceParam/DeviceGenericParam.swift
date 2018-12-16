//
//  DeviceGenericParam.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 11/6/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import ObjectMapper

class DeviceGenericParam: BaseParam {
    var jsonVersion: String?
    var cmd: String?
    var param = [SubDeviceGenericParam]()
    
    var mceId: String? // temp for MCE, will remove later
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.jsonVersion <- map["json_version"]
        self.cmd <- map["cmd"]
        self.param <- map["param"]
        self.mceId <- map["mce_id"]
    }
    
    // for apollo
    init(rgbw: String) {
        super.init()
        self.cmd = "set"
        self.jsonVersion = "0001"
        self.param.append(SubDeviceGenericParam(rgbw: rgbw))
    }
    
    // user other
    init(id: String?, type: String?, val: String?) {
        super.init()
        self.cmd = "set"
        self.jsonVersion = "0001"
        let newParam = SubDeviceGenericParam(id: id, type: type, val: val)
        self.param.append(newParam)
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
}


class SubDeviceGenericParam: BaseParam {
    var id: String?
    var type: String?
    var val: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["id"]
        self.type <- map["type"]
        self.val <- map["val"]
    }
    
    // user for Appolo
    init(rgbw: String) {
        super.init()
        self.id = "rgbw"
        self.type = "string"
        self.val = rgbw
    }
    
    // user other
    init(id: String?, type: String?, val: String?) {
        super.init()
        self.id = id
        self.type = type
        self.val = val
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
}


