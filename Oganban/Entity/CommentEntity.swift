//
//  CommentEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentEntity: BaseEntity {
    var comment: String?
    var subComment = [SubCommentEntity]()
    
    convenience init(comment: String) {
        self.init()
        self.comment = comment
    }
}
class SubCommentEntity: BaseEntity {
    var comment: String?
    
    convenience init(comment: String) {
        self.init()
        self.comment = comment
    }
}

class CommentResponseEntity: BaseEntity {
    var id: String?
    var accountId: String?
    var recordId: String?
    var comment: String?
    var createTime: Date?
    var user: UserEntity?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.accountId <- map["account_id"]
        self.recordId <- map["record_id"]
        self.createTime <- (map["create_time_mi"], yyyyMMddHHmmssTransform())
        self.comment <- map["comment"]
        self.user <- map["user"]
    }
    
    required init?(map: Map) {
        super.init()
    }
}

