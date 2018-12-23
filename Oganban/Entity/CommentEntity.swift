//
//  CommentEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

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
