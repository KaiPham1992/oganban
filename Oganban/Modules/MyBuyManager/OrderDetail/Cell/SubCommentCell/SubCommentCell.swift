//
//  CommentCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class SubCommentCell: BaseCommentCell {
    @IBOutlet weak var btnDelete: UIButton!
    
    var subComment: SubCommentEntity? {
        didSet {
            guard let _comment = subComment else { return }
            lbComment.text = _comment.comment
            lbTime.text = _comment.createTime?.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
            
            if let url = _comment.user?.urlAvatar {
                imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
                imgAvatar.setBorderWithCornerRadius(borderWidth: 1, borderColor: .clear, cornerRadius: 15)
            }
            
            btnDelete.isHidden = subComment?.user?.id != UserDefaultHelper.shared.loginUserInfo?.id
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lbComment.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 10)
    }
    
    @IBAction func btnDeleteTapped() {
        let id = subComment?.id&
        ProgressView.shared.show()
        Provider.shared.recordAPIService.deleteComment(commentID: id&, success: { _ in
            ProgressView.shared.hide()
            NotificationCenter.default.post(name: AppConstant.deleteSubComment, object: id&)
        }) { _error in
            PopUpHelper.shared.showMessageHaveAds(error: _error)
        }
    }
}
