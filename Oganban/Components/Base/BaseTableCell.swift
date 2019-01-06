//
//  BaseTableCell.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/22/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {
    let vLine: UIView = {
        let v = UIView()
        v.backgroundColor = AppColor.gray_233_233_234
        
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        self.selectionStyle = .none
    }
    
    func addLineToBottom() {
        addSubview(vLine)
        vLine.anchor( left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
}
