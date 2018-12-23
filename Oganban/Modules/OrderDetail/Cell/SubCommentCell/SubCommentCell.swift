//
//  CommentCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class SubCommentCell: BaseCommentCell {
    
    @IBOutlet weak var lbComment: CommentLabel!
    @IBOutlet weak var lbTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbComment.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 10)
    }
}
