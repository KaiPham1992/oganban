//
//  PopupOneButtonAction.swift
//  Oganban-Dev
//
//  Created by Coby on 3/21/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation

class PopupOneButtonAdmob: BasePopUpView {
    lazy var vHaveAdmob: PopupOneButton = {
        let v = PopupOneButton()
        v.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        return v
    }()
    
    var completionClose: CompletionClosure?
    override func setupView() {
        super.setupView()
        vContent.addSubview(vHaveAdmob)
        vHaveAdmob.fillSuperview()
    }
    
    func showPopUp(question: String, completionYes: @escaping CompletionClosure, completionClose: @escaping CompletionClosure) {
        let width = UIScreen.main.bounds.width - 30
        self.completionYes = completionYes
        self.completionClose = completionClose
        vHaveAdmob.lbQuestion.text = question
        super.showPopUp(width: width, height: 320, type: .zoomOut)
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        self.completionYes?()
    }
    
    override func btnCloseTapped() {
        super.btnCloseTapped()
        hidePopUp()
    }
    
    //    func admobNativeView(_ admobNativeView: AdmobNativeView) {
    //        hidePopUp()
    //    }
}
