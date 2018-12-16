//
//  NearCompareProjectView.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/18/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class NearCompareProjectView: BaseViewXib {
    @IBOutlet weak var vNearCompare: UIView!
    @IBOutlet weak var vPaintedProject: PaintedProjectView!
    
    @IBOutlet weak var btnNear: UIButton!
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var btnOver: UIButton!
    var project: ProjectEntity? {
        didSet {
            vPaintedProject.project = project
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        vNearCompare.setBorder(cornerRadius: vNearCompare.frame.height / 2)
    }
}
