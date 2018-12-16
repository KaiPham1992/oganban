//
//  LevelView.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 12/4/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class LevelView: BaseViewXib {
    @IBOutlet weak var lb1: AppLabel!
    @IBOutlet weak var lb2: AppLabel!
    @IBOutlet weak var lb3: AppLabel!
    @IBOutlet weak var lb4: AppLabel!
    @IBOutlet weak var lb5: AppLabel!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    
    var level = 0 {
        didSet {
           self.setData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        btn1.backgroundColor = UIColor(red: 97/255, green: 194/255, blue: 63/255, alpha: 1)
        btn2.backgroundColor = UIColor(red: 67/255, green: 146/255, blue: 139/255, alpha: 1)
        btn3.backgroundColor = UIColor(red: 237/255, green: 204/255, blue: 75/255, alpha: 1)
        btn4.backgroundColor = UIColor(red: 228/255, green: 127/255, blue: 57/255, alpha: 1)
        btn5.backgroundColor = UIColor(red: 220/255, green: 55/255, blue: 50/255, alpha: 1)
    }
    
    func setData() {
        if level < 5 {
            let buttons = [btn1, btn2, btn3, btn4, btn5]
            let labels: [AppLabel] = [lb1, lb2, lb3, lb4, lb5]
            for (index, btn) in buttons.enumerated() {
                if index <= level {
                    btn?.setImage(AppImage.imgChecked, for: .normal)
                }
            }
            showLabel(label: labels[level])
        }
    }
    
    
    func showLabel(label: AppLabel) {
        hideLabel()
        label.isHidden = false
    }
    
    func hideLabel() {
        lb1.isHidden = true
        lb2.isHidden = true
        lb3.isHidden = true
        lb4.isHidden = true
        lb5.isHidden = true
    }
}
