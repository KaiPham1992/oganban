//
//  CommentCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class SubCommentCell: BaseCommentCell {
    
    var subComment: SubCommentEntity? {
        didSet {
            guard let _comment = subComment else { return }
            lbComment.text = _comment.comment
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lbComment.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 10)
    }
}
