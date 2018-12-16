//
//  NoDataView.swift
//  GoFixProvider
//
//  Created by Coby on 12/3/18.
//  Copyright © 2018 sg.vinova.gofixProvider. All rights reserved.
//

import Foundation
import UIKit

class NoDataView: UIView {
    
    var imgNoResult: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "file")
        return img
    }()
    
    var lbNoResult: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    func setupViews() {
        self.addSubview(imgNoResult)
        self.addSubview(lbNoResult)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setUpSize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setUpSize()
    }
    
    func setUpSize() {
        imgNoResult.anchor(bottom: lbNoResult.topAnchor, bottomConstant: 10, widthConstant: 96, heightConstant: 96)
        imgNoResult.centerXToSuperview()
        lbNoResult.centerYToSuperview()
        lbNoResult.centerXToSuperview()
    }
    
    func setTitle(title: String) {
        lbNoResult.text = title
        lbNoResult.font = AppFont.fontRegular15
    }
}
