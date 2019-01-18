//
//  PopUpSettingGPS.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

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
//        hidePopUp()
        if !CLLocationManager.locationServicesEnabled() {
            if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                // If general location settings are disabled then open general location settings
                UIApplication.shared.open(url)
            }
        } else {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                // If general location settings are enabled then open location settings for the app
                UIApplication.shared.open(url)
            }
        }
        
//        if let bundleId = Bundle.main.bundleIdentifier,
//            let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
//        {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
       
    }
}
