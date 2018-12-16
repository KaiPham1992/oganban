//
//  ConsultationStaffView.swift
//  RedStar
//
//  Created by Coby on 11/21/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

enum RankState: String {
    case bronze = "Đồng"
    case silver = "Bạc"
    case gold = "Vàng"
    case platinum = "Bạch Kim"
    case diamon = "Kim Cương"
}

class ConsultationStaffView: BaseViewXib {
    
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var vContent: UIView!
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var vInfo: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var vRating: RatingNewView!
    @IBOutlet weak var vLikeAndRank: LikeAndRankView!
    @IBOutlet weak var vAchievementOne: AchievementView!
    @IBOutlet weak var vAchievementTwo: AchievementView!
    
    var consultationStaff: ConsultationStaffEntity? {
        didSet {
            guard let _consultationStaff = consultationStaff else { return }
            lbName.text = _consultationStaff.name
            vRating.rateNum = Double(_consultationStaff.saleRating!)
            vRating.lbCount.text = "(\(_consultationStaff.numberRating ?? "0")) "
            vLikeAndRank.lbLike.text = _consultationStaff.likeNum
            vAchievementOne.lbTitle.text = _consultationStaff.achievementOne
            vAchievementTwo.lbTitle.text = _consultationStaff.achievementTwo
            setHidenView()
            setFavorite()
            vLikeAndRank.setRank(consultationStaff: _consultationStaff)
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_consultationStaff.avatar ?? "")") {
                imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgDemoProject)
            }
        }
    }
    
    var consultationDetailStaff: ConsultationStaffDetailEntity? {
        didSet {
            guard let _consultationDetailStaff = consultationDetailStaff else { return }
            lbName.text = _consultationDetailStaff.name
            vRating.rateNum = Double(_consultationDetailStaff.numberRating!)
            vLikeAndRank.lbLike.text = _consultationDetailStaff.likeNum
            vAchievementOne.lbTitle.text = _consultationDetailStaff.achievementOne
            vAchievementTwo.lbTitle.text = _consultationDetailStaff.achievementTwo
            setHidenView()
            vLikeAndRank.setRank(consultationStaff: _consultationDetailStaff)
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_consultationDetailStaff.avatar ?? "")") {
                imgAvatar.sd_setImage(with: url, placeholderImage: AppImage.imgDemoProject)
            }
        }
    }
    
    func setFavorite() {
        guard let _consultationStaff = consultationStaff else { return }
        vLikeAndRank.imgLike.image = AppImage.imgLikeOff
        vLikeAndRank.imgLike.tintColor = AppColor.grayDark
        vLikeAndRank.lbLike.textColor = AppColor.grayDark
        if let _ = UserUtils.getLoginToken(), let isFavorite = _consultationStaff.isFavorite {
            if isFavorite {
                vLikeAndRank.imgLike.image = AppImage.imgFavoriteOn
                vLikeAndRank.lbLike.textColor = AppColor.redHot
            } else {
                vLikeAndRank.imgLike.image = AppImage.imgLikeOff
                vLikeAndRank.imgLike.tintColor = AppColor.grayDark
                vLikeAndRank.lbLike.textColor = AppColor.grayDark
            }
        }
    }
    
    func setHidenView() {
        if consultationStaff?.achievementOne == nil {
            vAchievementOne.isHidden = true
        }
        
        if consultationStaff?.achievementTwo == nil {
            vAchievementTwo.isHidden = true
        }
    }
    
    override func draw(_ rect: CGRect) {
//        showShadowBoder()
    }
    
    
    func showShadowBoder() {
        vShadow.setShadow(color: .black, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
        vContent.setBorder(borderWidth: 0.5, borderColor:AppColor.gray, cornerRadius: 5)

    }
    
    func hideShadowBorder() {
        vShadow.setShadow(color: .white, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
        vContent.setBorder(borderWidth: 0.5, borderColor:AppColor.white, cornerRadius: 5)

    }
    
    override func setUpViews() {
        imgAvatar.setBorder(cornerRadius: imgAvatar.frame.width / 2 )
        vRating.rateNum = 3.5
    }
    
}
