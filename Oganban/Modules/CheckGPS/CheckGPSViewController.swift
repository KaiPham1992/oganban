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
        locationManager.delegate = self
        vPopUpSettingGPSContent.btnSetting.addTarget(self, action: #selector(settingTapped), for: UIControl.Event.touchUpInside)
        
        vPopUpSettingGPSContent.btnClose.addTarget(self, action: #selector(btnCloseSettingTapped), for: UIControl.Event.touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    @objc func btnCloseSettingTapped() {
        UserDefaultHelper.shared.saveLocation(lat: CLLocationDegrees(10.7879313), long: CLLocationDegrees(106.6149738), address: "Số 235 Đường Lê Thúc Hoạch, Phường Phú Thọ Hoà, Quận Tân Phú, Thành phố Hồ Chí Minh")
        NotificationCenter.default.post(name: Notification.Name("SaveLocation"), object: nil)
        self.dismiss()
    }
    
}

extension CheckGPSViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
          
        } else {
            manager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if UserDefaultHelper.shared.lat == "" {
                 getAddressFromLocation(pdblLatitude: CGFloat(location.coordinate.latitude), withLongitude: CGFloat(location.coordinate.longitude))
            }
           
            self.locationManager.stopUpdatingLocation()
        }
        
    }
    
    func getAddressFromLocation(pdblLatitude: CGFloat, withLongitude pdblLongitude: CGFloat) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var addressString : String = ""
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                   
                    UserDefaultHelper.shared.saveLocation(lat: CLLocationDegrees(pdblLatitude), long: CLLocationDegrees(pdblLongitude), address: addressString)
                    NotificationCenter.default.post(name: Notification.Name("SaveLocation"), object: nil)
                }
        })
    }
}
