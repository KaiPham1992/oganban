//
//  AppSearchBar.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/25/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

protocol AppSearchBarDelegate: class {
    func didTextChanged(text: String)
}

class AppSearchBar: BaseViewXib {
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
    }
    
    weak var delegate: AppSearchBarDelegate?
    
    @IBAction func btnDeleteTapped() {
        tfInput.text = ""
        btnDelete.isHidden = true
        
    }
    
    @objc func textFieldDidChanged() {
        if tfInput.text&.isValidEmpty() {
            btnDelete.isHidden = true
        } else {
            btnDelete.isHidden = false
        }
        
        delegate?.didTextChanged(text: tfInput.text&)
    }
}
