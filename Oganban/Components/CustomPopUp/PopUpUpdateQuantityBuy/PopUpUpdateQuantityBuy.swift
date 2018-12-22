//
//  PopUpUpdateQuantityBuy.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class PopUpUpdateQuantityBuy: BasePopUpView {
    lazy var vHaveAdmob: PopUpUpdateQuantityBuyContent = {
        let v = PopUpUpdateQuantityBuyContent()
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        return v
    }()
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vHaveAdmob)
        vHaveAdmob.fillSuperview()
    }
    
    func showPopUp(completionYes: @escaping CompletionClosure) {
        let width = UIScreen.main.bounds.width - 30
        self.completionYes = completionYes
        super.showPopUp(width: width, height: 320, type: .zoomOut)
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        self.completionYes?()
    }
}
