//
//  CheckGPSViewController.swift
//  Oganban
//
//  Created by Kai Pham on 1/17/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit
import GooglePlaces

class CheckGPSViewController: BaseViewController {
    @IBOutlet weak var vPopUpSettingGPSContent: PopUpSettingGPSContent!
     var locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.red_110_0_0
        setColorStatusBar(color: AppColor.red_110_0_0)
        
        vPopUpSettingGPSContent.btnSetting.addTarget(self, action: #selector(settingTapped), for: UIControl.Event.touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("lksjkljaskljklajskl")
        super.viewWillAppear(animated)
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
           self.dismiss()
        } else {
             locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @objc func settingTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            // If general location settings are enabled then open location settings for the app
            UIApplication.shared.open(url)
        }
    }
    
}
