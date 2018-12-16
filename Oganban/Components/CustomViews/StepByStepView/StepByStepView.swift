//
//  StepByStepView.swift
//  RedStar
//
//  Created by Coby on 12/4/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit
class StepByStepView: BaseViewXib {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var imgDot1: UIImageView!
    @IBOutlet weak var imgDot2: UIImageView!
    @IBOutlet weak var imgDot3: UIImageView!
    @IBOutlet weak var lbTitle1: UILabel!
    @IBOutlet weak var lbTitle2: UILabel!
    @IBOutlet weak var lbTitle3: UILabel!
    @IBOutlet weak var lbTitle4: UILabel!
    
    override func setUpViews() {
        view1.setBorder(cornerRadius: view1.frame.width/2)
        view2.setBorder(cornerRadius: view2.frame.width/2)
        view3.setBorder(cornerRadius: view3.frame.width/2)
        view4.setBorder(cornerRadius: view4.frame.width/2)
    }
    
    func setStept1() {
        view1.backgroundColor = AppColor.greenLow
        lbTitle1.textColor = AppColor.greenLow
    }
    func setStept2() {
        view1.backgroundColor = AppColor.greenLow
        imgDot1.image = AppImage.imgMoreProgressOn
        imgDot1.tintColor = AppColor.greenLow
        view2.backgroundColor = AppColor.greenLow
        lbTitle1.textColor = AppColor.greenLow
        
    }
    func setStept3() {
        view1.backgroundColor = AppColor.greenLow
        imgDot1.image = AppImage.imgMoreProgressOn
        imgDot1.tintColor = AppColor.greenLow
        view2.backgroundColor = AppColor.greenLow
        imgDot2.image = AppImage.imgMoreProgressOn
        imgDot2.tintColor = AppColor.greenLow
        view3.backgroundColor = AppColor.greenLow
        lbTitle1.textColor = AppColor.greenLow
        lbTitle2.textColor = AppColor.greenLow
        lbTitle3.textColor = AppColor.greenLow
    }
    func setStept4() {
        view1.backgroundColor = AppColor.greenLow
        imgDot1.image = AppImage.imgMoreProgressOn
        imgDot1.tintColor = AppColor.greenLow
        view2.backgroundColor = AppColor.greenLow
        imgDot2.image = AppImage.imgMoreProgressOn
        imgDot2.tintColor = AppColor.greenLow
        view3.backgroundColor = AppColor.greenLow
        imgDot3.image = AppImage.imgMoreProgressOn
        imgDot3.tintColor = AppColor.greenLow
        view4.backgroundColor = AppColor.greenLow
        lbTitle1.textColor = AppColor.greenLow
        lbTitle2.textColor = AppColor.greenLow
        lbTitle3.textColor = AppColor.greenLow
        lbTitle4.textColor = AppColor.greenLow
    }
}
