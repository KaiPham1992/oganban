//
//  AppLabel.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class AppLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setUpView() {
        
    }
    
    func setFont(size: CGFloat, font: UIFont = AppFont.fontRegular17) {
        self.font = UIFont(descriptor: font.fontDescriptor, size: size)
    }
}
