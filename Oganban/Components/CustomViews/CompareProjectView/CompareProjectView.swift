//
//  CompareProjectView.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/18/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class CompareProjectView: BaseViewXib {
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var btnResult: UIButton!
    
    //--
    @IBOutlet weak var vProject1: TextFiledMarkerView!
    @IBOutlet weak var vProject2: TextFiledMarkerView!
    
    var project: ProjectEntity? {
        didSet {
            guard let _project = project else { return }
            
            if vProject1.project == nil {
               
                if vProject2.project?.id != _project.id{
                     vProject1.project = _project
                     _project.indexCompare = 1
                }
               
            } else {
               
                if vProject1.project?.id != _project.id{
                    vProject2.project = _project
                     _project.indexCompare = 2
                }
            }
            
            
            
            //---
            if vProject1.project != nil && vProject2.project != nil {
                btnResult.backgroundColor = AppColor.red
                btnResult.isEnabled = true
            } else {
                btnResult.backgroundColor = AppColor.gray
                btnResult.isEnabled = false
            }
            
            //---- post 2 project 
            NotificationCenter.default.post(name: NotificationConstant.selectedProjectCompare, object: [vProject1.project, vProject2.project])
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        self.backgroundColor = .clear
        vShadow.setShadow(color: UIColor.black, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
        vContent.setBorder(cornerRadius: 5)
        vProject1.delegate = self
        vProject2.delegate = self
        vProject2.imgIcon.image = AppImage.imgMarker2
    }
}

extension CompareProjectView: TextFiledMarkerViewDelegate {
    func btnDeleteTapped() {
        btnResult.backgroundColor = AppColor.gray
        btnResult.isEnabled = false
        NotificationCenter.default.post(name: NotificationConstant.selectedProjectCompare, object: [vProject1.project, vProject2.project])
    }
}
