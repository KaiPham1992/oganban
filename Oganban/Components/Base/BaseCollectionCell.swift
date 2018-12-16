//
//  BaseCollectionCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/24/18.
//  Copyright © 2018 Engma. All rights reserved.
//


import UIKit

class BaseCollectionCell: UICollectionViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        clipsToBounds = true
    }
}

