//
//  ReplyCommentCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class ReplyCommentCell: BaseTableCell {
    
    @IBOutlet weak var vPostCommentView: PostCommentView!

    override func awakeFromNib() {
        super.awakeFromNib()
        vPostCommentView.setPlaceHolder(placeHolder: "Viết trả lời")
    }
}
