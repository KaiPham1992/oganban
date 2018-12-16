//
//  File.swift
//  RedStar
//
//  Created by Coby on 11/17/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit

class AppHeaderTitle: BaseView {
    
    lazy var lbTitle: UILabel = {
       let title = UILabel()
        title.font = AppFont.fontBold15
        return title
    }()
    
    override func setUpViews() {
         addSubview(lbTitle)
        lbTitle.anchor(self.topAnchor,left: self.leftAnchor, topConstant: 30, leftConstant: 15, heightConstant: 25)
       
    }
}
