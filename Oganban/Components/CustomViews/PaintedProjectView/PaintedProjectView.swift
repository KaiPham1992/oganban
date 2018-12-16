//
//  PaintedProjectView.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/18/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit
import SDWebImage

class PaintedProjectView: BaseViewXib {
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var vContent: UIView!
    
    @IBOutlet weak var lbProjectName: AppLabel!
    @IBOutlet weak var imgHot: UIImageView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var imgFavorite: UIImageView!
    @IBOutlet weak var lbSortDescription: AppLabel!
    @IBOutlet weak var vGroup: ImageLabelView!
    @IBOutlet weak var vType: ImageLabelView!
    @IBOutlet weak var vPrice: ImageLabelView!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var imgProject: UIImageView!
    
    var project: ProjectEntity? {
        didSet {
            guard let _project = project else { return }
            if _project.name != nil {
                lbProjectName.text = _project.name
            } else {
                lbProjectName.text = _project.name2
            }
            
            if _project.sortDescription&.isEmpty {
                lbSortDescription.text = "Chưa có thông tin dự án"
            } else {
                lbSortDescription.text = _project.sortDescription
            }
            if _project.group != nil {
                vGroup.lbTitle.text = _project.group
            } else {
                vGroup.lbTitle.text = _project.group2
            }
            
            vType.lbTitle.text = _project.projectType?.rawValue
            vPrice.lbTitle.text = _project.toPriceShow()
            
            if let distance =  _project.distance, let distanceDou = Double(distance)?.toDistance() {
                lbDistance.text = distanceDou
            }
            
            if let url = URL(string: "\(BASE_URL_IMAGE)\(_project.imgUrl ?? "")") {
                imgProject.sd_setImage(with: url, placeholderImage: AppImage.imgDemoProject)
            }
            
            setProjectHot()
            checkCompareProject()
            setFavorite()
        }
    }
    
    var isFavorite: Bool = true {
        didSet {
             if isFavorite {
                imgFavorite.image = AppImage.imgLikeOn
            }
        }
    }
    
  
    func setProjectHot() {
        guard let _project = project else { return }
        if _project.isHot {
            imgHot.isHidden = false
            imgHot.image = AppImage.imgHot.withRenderingMode(.alwaysTemplate)
            imgHot.tintColor = AppColor.redHot
            vContent.setBorder(borderWidth: 0.5, borderColor: AppColor.red, cornerRadius: 5)
           
            return
        }
        
    }
    
    func setFavorite() {
        guard let _project = project else { return }
        imgFavorite.image = AppImage.imgFavoriteOff
        if let _ = UserUtils.getLoginToken(), let isFavorite = _project.favorite {
            if isFavorite {
                imgFavorite.image = AppImage.imgFavoriteOn
            } else {
                imgFavorite.image = AppImage.imgFavoriteOff
            }
        }
    }
    
    func checkCompareProject() {
        if project?.indexCompare == 1 {
            imgSelected.isHidden = false
            imgSelected.image = AppImage.imgCompareProject1
            return
        } else if project?.indexCompare == 2 {
            imgSelected.isHidden = false
            imgSelected.image = AppImage.imgCompareProject2
            return
        } else {
            imgSelected.isHidden = true
            return
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let _project = project else { return }
        if _project.isHot {
            vShadow.setShadow(color: AppColor.red, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
            vContent.setBorder(borderWidth: 0.5, borderColor: AppColor.red, cornerRadius: 5)

            return
        } else {
            vShadow.setShadow(color: UIColor.black, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
            vContent.setBorder(borderWidth: 0.5, borderColor: AppColor.gray, cornerRadius: 5)

        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        self.backgroundColor = .clear
        vGroup.setImage(image: AppImage.imgOwner)
        vType.setImage(image: AppImage.imgHome)
        vPrice.setImage(image: AppImage.imgPrice)
        imgHot.isHidden = true
        
    }
}
