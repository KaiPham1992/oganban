//
//  PopUpUpdateQuantityBuy.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class PopUpUpdateQuantityBuy: BasePopUpView {
    lazy var vQuantity: PopUpUpdateQuantityBuyContent = {
        let v = PopUpUpdateQuantityBuyContent()
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        v.btnCompleted.addTarget(self, action: #selector(btnCompletedTapped), for: .touchUpInside)
        return v
    }()
    
    var completionQuantity: CompletionMessage?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vQuantity)
        vQuantity.fillSuperview()
    }
    
    func showPopUp(completionQuantity: @escaping CompletionMessage) {
        let width = UIScreen.main.bounds.width - 30
        self.completionQuantity = completionQuantity
        super.showPopUp(width: width, height: 205, type: .zoomOut)
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        self.completionYes?()
    }
    
    @objc func btnCompletedTapped() {
        if !vQuantity.tfQuantity.text&.isEmpty {
            hidePopUp()
            completionQuantity?(vQuantity.tfQuantity.text&)
        }
    }
}
