//
//  TextFiledMarkerView.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/18/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

protocol TextFiledMarkerViewDelegate: class {
    func btnDeleteTapped()
}

class TextFiledMarkerView: BaseViewXib {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var tfInput: UITextField!
    
    var project: ProjectEntity? {
        didSet {
            guard let _project = project else {
                tfInput.text = ""
                return
            }
            tfInput.text = _project.name&
        }
    }
    
    weak var delegate: TextFiledMarkerViewDelegate?
    
    @IBAction func btnDeleteTapped() {
        self.project = nil
        delegate?.btnDeleteTapped()
    }
    
    override func setUpViews() {
        super.setUpViews()
        tfInput.isEnabled = false
    }
}
