//
//  PopUpSelectDate.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class PopUpSelectDate: BasePopUpView, PopUpSelectDateContentDelegate {
    lazy var vDateContent: PopUpSelectDateContent = {
        let v = PopUpSelectDateContent()
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        v.delegate = self
        return v
    }()
    
    var completionDate: CompletionDate?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vDateContent)
        vDateContent.fillSuperview()
    }
    
    func showPopUp(currentDate: Date? = nil, completionDate: CompletionDate?) {
        vDateContent.vPickerDate.date = currentDate ?? Date()
        self.completionDate = completionDate
        
        showPopUp(width: 0, height: 256, type: .showFromBottom)
    }
    
    func dateSelected(date: Date?) {
        hidePopUp()
        completionDate?(date)
    }
    
}

