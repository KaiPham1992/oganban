//
//  MarkerProject.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/17/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class MarkerProjectView: BaseViewXib {
    @IBOutlet weak var lbName: AppLabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var imgTriangle: UIImageView!
    
    var project: ProjectEntity? {
        didSet {
            guard let _project = project, let nameProject = _project.name else { return }
            imgTriangle.image = AppImage.imgTriangle
            lbName.text = _project.name&.getSub(count: 17)
            lbName.backgroundColor = _project.isHot ? AppColor.red: AppColor.green
            imgTriangle.tintColor = _project.isHot ? AppColor.red: AppColor.green
            lbName.setBorder(cornerRadius: 7.5)
            lbName.setFont(size: 12)
            let withlbName =  Utils.estimateWidth(lbName.font.lineHeight, customFont: lbName.font, str: nameProject) + 60
            
            self.frame = CGRect(x: 0, y: 0, width: withlbName, height: lbName.frame.height + imgIcon.frame.height + 10 + 10)
            switch _project.indexCompare {
            case 1:
                self.isHidden = false
                imgIcon.image = AppImage.imgGreenMarker
                lbName.isHidden = true
                imgTriangle.isHidden = lbName.isHidden
                lbName.text = ""
                break
            case 2:
                self.isHidden = false
                imgIcon.image = AppImage.imgRedMarker
                lbName.isHidden = true
                imgTriangle.isHidden = lbName.isHidden
                lbName.text = ""
                break
            default :
                self.isHidden = false
                imgIcon.image = _project.toImageIcon()
                lbName.isHidden = false
                imgTriangle.isHidden = lbName.isHidden
                break
            }
        }
    }
}
