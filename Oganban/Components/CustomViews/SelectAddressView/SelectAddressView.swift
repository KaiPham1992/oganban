//
//  SelectAddressView.swift
//  RedStar
//
//  Created by Coby on 11/29/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit

protocol SelectAddressViewDelegate: class {
    func btnSelectTapped(view: UIView)
}

class SelectAddressView: BaseViewXib {
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnSelectAddress: UIButton!
    
    weak var delegate: SelectAddressViewDelegate?
    var isSelect: Bool = false
    
    override func setUpViews() {
        
    }
    
    func setContent(title: String) {
        lbTitle.text = title
    }
    
    @IBAction func btnSelectedTapped() {
        delegate?.btnSelectTapped(view: self)
    }
    
}
