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
    var id: String?
    var accountId: String?
    var recordId: String?
    var comment: String?
    var createTime: Date?
    var user: UserEntity?
    var totalReplyComment: Int?
    var isDelete: String?
    var subComment = [SubCommentEntity]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.accountId <- map["account_id"]
        self.recordId <- map["record_id"]
        self.createTime <- (map["create_time_mi"], AppTimestampTransform())
        self.comment <- map["comment"]
        self.user <- map["user"]
        self.totalReplyComment <- map["total_re_cmt"]
        self.isDelete <- map["is_delete"]
        self.subComment <- map["re_cmt"]
    }
    
}

class CommentChildEntity: BaseEntity {
    var totalComment: Int?
    var subCommnent: [SubCommentEntity] = []
    
    override func mapping(map: Map) {
        self.totalComment <- map["total_re_cmt"]
        self.subCommnent <- map["comment"]
    }
    
}

class SubCommentEntity: BaseEntity {
    var id: String?
    var accountId: String?
    var recordId: String?
    var comment: String?
    var createTime: Date?
    var user: UserEntity?
    var totalReplyComment: Int?
    var isDelete: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.accountId <- map["account_id"]
        self.recordId <- map["record_id"]
        self.createTime <- (map["create_time_mi"], AppTimestampTransform())
        self.comment <- map["comment"]
        self.user <- map["user"]
        self.totalReplyComment <- map["total_re_cmt"]
        self.isDelete <- map["is_delete"]
    }
}

class CommentResponseEntity: BaseEntity {
    
    var listComment = [CommentEntity]()
    var totalComment: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.totalComment <- map["total_cmt"]
        self.listComment <- map["comment"]
    }
    
    required init?(map: Map) {
        super.init()
    }
}

