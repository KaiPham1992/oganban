//
//  AppDelegate+GoogleSignIn.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import GoogleSignIn

extension AppDelegate {
    func configureGoogle() {
        GMSServices.provideAPIKey("AIzaSyAmIuvnBJnc4ohauvfrjLvVaZPeamzTcbs")
        GMSPlacesClient.provideAPIKey("AIzaSyAmIuvnBJnc4ohauvfrjLvVaZPeamzTcbs")
        GIDSignIn.sharedInstance().clientID = "1004012986328-dasmg85c0k91bvs6v6s4r3inb7lh5q5d.apps.googleusercontent.com"
    }
    
    func setUpStatusBar() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
        statusBar.backgroundColor = AppColor.red
    }
}
