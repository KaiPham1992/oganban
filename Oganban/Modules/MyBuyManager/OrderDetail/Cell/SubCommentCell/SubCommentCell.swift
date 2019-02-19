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
            
            let attr = NSMutableAttributedString()
            let fullName = _comment.user?.fullName&
            let attr1 = "\(fullName&) ".toAttributedString(color: .black, font: AppFont.fontBold15, isUnderLine: false)
            let attr2 = _comment.comment&.toAttributedString(color: lbComment.textColor, font: AppFont.fontRegular15, isUnderLine: false)
            
            attr.append(attr1)
            attr.append(attr2)
            lbComment.attributedText = attr
            
            //---
            
            lbTime.text = _comment.createTime?.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
            
            if let url = _comment.user?.urlAvatar {
                imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgDefaultUser)
                imgAvatar.setBorderWithCornerRadius(borderWidth: 1, borderColor: .clear, cornerRadius: 15)
            }  else {
                imgAvatar.image = AppImage.imgDefaultUser
            }
            
            if subComment?.user?.id == UserDefaultHelper.shared.loginUserInfo?.id {
                if let url = UserDefaultHelper.shared.loginUserInfo?.urlAvatar {
                    imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgDefaultUser)
                    imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 15)
                }
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
