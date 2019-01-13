//
//  BaseCommentCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class BaseCommentCell: BaseTableCell {
    @IBOutlet weak var lbComment: CommentLabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
}
