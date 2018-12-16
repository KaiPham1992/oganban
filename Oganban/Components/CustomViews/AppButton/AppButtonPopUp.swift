//
//  AppButtonPopUp.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class AppButtonPopUp: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        self.titleLabel?.font = AppFont.fontRegular15
        self.titleLabel?.textColor = AppColor.white
        
        self.setTitleColor(AppColor.white, for: UIControl.State.highlighted)
        self.setTitleColor(AppColor.white, for: UIControl.State.normal)
        self.setTitleColor(AppColor.white, for: UIControl.State.selected)
    }
    
    override var isHighlighted: Bool {
        didSet {
            print("isHighlighted: \(isHighlighted)")
            changeColor(isTrue: isHighlighted)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            print("isSelected: \(isSelected)")
            changeColor(isTrue: isSelected)
        }
    }
    
    private func changeColor(isTrue: Bool) {
        if isTrue {
            self.backgroundColor = AppColor.red
            self.titleLabel?.alpha = 1
        } else {
            self.backgroundColor = AppColor.clear
        }
    }
    
}
