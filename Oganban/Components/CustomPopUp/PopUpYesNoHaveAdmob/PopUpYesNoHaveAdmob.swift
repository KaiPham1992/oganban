//
//  PopUpYesNoHaveAdmob.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class PopUpYesNoHaveAdmob: BasePopUpView {
    lazy var vHaveAdmob: PopUpYesNoHaveAdmobContent = {
        let v = PopUpYesNoHaveAdmobContent()
        v.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
        v.btnNo.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        return v
    }()
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vHaveAdmob)
        vHaveAdmob.fillSuperview()
    }
    
    func showPopUp(question: String, completionYes: @escaping CompletionClosure, completionNo: @escaping CompletionClosure) {
        let width = UIScreen.main.bounds.width - 30
        self.completionNo = completionNo
        self.completionYes = completionYes
        vHaveAdmob.lbQuestion.text = question
        super.showPopUp(width: width, height: 320, type: .zoomOut)
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        self.completionYes?()
    }
    
    override func btnCloseTapped() {
        super.btnCloseTapped()
        self.completionNo?()
    }
}
