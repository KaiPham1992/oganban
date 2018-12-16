//
//  DotsView.swift
//  RedStar
//
//  Created by Coby on 12/4/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class DotsView: BaseView {
    
    var colorDot = AppColor.gray.cgColor
    let xCoord: CGFloat = 0
    let yCoord: CGFloat = 20
    let radius: CGFloat = 4
    
    override func setUpViews() {
        
        let dotPath1 = UIBezierPath(ovalIn: CGRect(x: xCoord, y: yCoord, width: radius, height: radius))
        let dotPath2 = UIBezierPath(ovalIn: CGRect(x: xCoord + 10.0, y: yCoord, width: radius, height: radius))
        let dotPath3 = UIBezierPath(ovalIn: CGRect(x: xCoord + 20.0, y: yCoord, width: radius, height: radius))
        let dotPath4 = UIBezierPath(ovalIn: CGRect(x: xCoord + 30.0, y: yCoord, width: radius, height: radius))
        let dotPath5 = UIBezierPath(ovalIn: CGRect(x: xCoord + 40.0, y: yCoord, width: radius, height: radius))
        let dotPath6 = UIBezierPath(ovalIn: CGRect(x: xCoord + 50.0, y: yCoord, width: radius, height: radius))
        
        let layer1 = CAShapeLayer()
        layer1.path = dotPath1.cgPath
        layer1.strokeColor = AppColor.gray.cgColor
        
        let layer2 = CAShapeLayer()
        layer2.path = dotPath2.cgPath
        layer2.strokeColor = AppColor.gray.cgColor
        
        let layer3 = CAShapeLayer()
        layer3.path = dotPath3.cgPath
        layer3.strokeColor = AppColor.gray.cgColor
        
        let layer4 = CAShapeLayer()
        layer4.path = dotPath4.cgPath
        layer4.strokeColor = AppColor.gray.cgColor
        
        let layer5 = CAShapeLayer()
        layer5.path = dotPath5.cgPath
        layer5.strokeColor = AppColor.gray.cgColor
        
        let layer6 = CAShapeLayer()
        layer6.path = dotPath6.cgPath
        layer6.strokeColor = AppColor.gray.cgColor
        
        self.layer.addSublayer(layer1)
        self.layer.addSublayer(layer2)
        self.layer.addSublayer(layer3)
        self.layer.addSublayer(layer4)
        self.layer.addSublayer(layer5)
        self.layer.addSublayer(layer6)
    }
    
    func setInStepSelect(isStepSelect: Bool) {
//        layer1.strokeColor = AppColor.greenLow.cgColor
//        layer2.strokeColor = AppColor.greenLow.cgColor
//        layer3.strokeColor = AppColor.greenLow.cgColor
//        layer4.strokeColor = AppColor.greenLow.cgColor
//        layer5.strokeColor = AppColor.greenLow.cgColor
//        layer6.strokeColor = AppColor.greenLow.cgColor
    }
}
