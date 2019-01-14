//
//  PopUpSelectDate.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class PopUpSelectGender: BasePopUpView, PopUpSelectGenderContentDelegate {
    lazy var vGenderContent: PopUpSelectGenderContent = {
        let v = PopUpSelectGenderContent()
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        v.delegate = self
        return v
    }()
    
    var completionGender: CompletionAny?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vGenderContent)
        vGenderContent.fillSuperview()
    }
    
    func showPopUp(currentGender: Gender?, completionGender: CompletionAny?) {
        self.completionGender = completionGender
        vGenderContent.genderSelected = currentGender
        showPopUp(width: 0, height: 220, type: .showFromBottom)
        vGenderContent.showSelectRow()
       
    }
    
    func genderSelected(gender: Gender?) {
        hidePopUp()
        completionGender?(gender)
    }
    
}

