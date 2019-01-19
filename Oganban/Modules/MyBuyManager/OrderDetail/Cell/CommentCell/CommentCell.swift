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
            
            let attr = NSMutableAttributedString()
            let fullName = _comment.user?.fullName&
            let attr1 = "\(fullName&) ".toAttributedString(color: .black, font: AppFont.fontBold15, isUnderLine: false)
            let attr2 = _comment.comment&.toAttributedString(color: lbComment.textColor, font: AppFont.fontRegular15, isUnderLine: false)
            
            attr.append(attr1)
            attr.append(attr2)
            lbComment.attributedText = attr
            
            
            lbTime.text = _comment.createTime?.toString(dateFormat: AppDateFormat.ddMMYYYY_VN)
            
            if let url = _comment.user?.urlAvatar {
                imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgDefaultUser)
                imgAvatar.setBorderWithCornerRadius(borderWidth: 1, borderColor: .clear, cornerRadius: 15)
            } else {
                imgAvatar.image = AppImage.imgDefaultUser
            }
            
            btnDelete.isHidden = comment?.user?.id != UserDefaultHelper.shared.loginUserInfo?.id
            
        }
    }
    
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbComment.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 10)
    }
    
    @IBAction func btnDeleteTapped() {
        let id = comment?.id&
        ProgressView.shared.show()
        Provider.shared.recordAPIService.deleteComment(commentID: id&, success: { _ in
            ProgressView.shared.hide()
            NotificationCenter.default.post(name: AppConstant.deleteComment, object: id&)
        }) { _error in
            PopUpHelper.shared.showMessageHaveAds(error: _error)
        }
    }
}
