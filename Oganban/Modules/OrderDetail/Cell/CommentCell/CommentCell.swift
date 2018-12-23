//
//  CommentCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class CommentLabel: UILabel {
    var padding: CGFloat = 8
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: padding)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding + padding,
                      height: size.height + padding + padding)
    }
}

class CommentCell: BaseCommentCell {
    
    var comment: CommentEntity? {
        didSet {
            guard let _comment = comment else { return }
            lbComment.text = _comment.comment
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbComment.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 10)
    }
}
