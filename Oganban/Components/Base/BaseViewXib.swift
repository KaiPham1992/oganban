//
//  BaseViewXib.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import UIKit

class BaseViewXib: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let nibName     = String(describing: type(of: self))
        let nib         = UINib(nibName: nibName, bundle: Bundle.main)
        let view        = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame      = bounds
        addSubview(view)
        view.fillVerticalSuperview()
        view.fillHorizontalSuperview()
        setUpViews()
    }
    
    func setUpViews() {
        
    }
}

