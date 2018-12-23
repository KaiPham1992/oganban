//
//  PopUpSettingGPS.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class PopUpSettingGPS: BasePopUpView {
    lazy var vSetting: PopUpSettingGPSContent = {
        let v = PopUpSettingGPSContent()
        v.btnClose.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        v.btnSetting.addTarget(self, action: #selector(btnSettingTapped), for: .touchUpInside)
        return v
    }()
    
    var completionQuantity: CompletionMessage?
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vSetting)
        vSetting.fillSuperview()
    }
    
    func showPopUp() {
        let width = UIScreen.main.bounds.width - 30
        super.showPopUp(width: width, height: 180, type: .zoomOut)
    }
    
    @objc func btnSettingTapped() {
        hidePopUp()
        
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
