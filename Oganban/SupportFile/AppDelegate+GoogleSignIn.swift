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
import GoogleMobileAds
import Firebase

extension AppDelegate {
    func configureGoogle() {
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        
        // get key from fire base : AIzaSyCaOVKfotVN6tQ4sUbv8ssND
        #if APPSTORE
        GMSServices.provideAPIKey("AIzaSyCaOVKfotVN6tQ4sUbv8ssND-4zmssrdPk")
        GMSPlacesClient.provideAPIKey("AIzaSyCaOVKfotVN6tQ4sUbv8ssND-4zmssrdPk")
        GIDSignIn.sharedInstance().clientID = "184896964264-hasu05ond65e5am0u9oev8vbqffk3e0o.apps.googleusercontent.com"
        #else
        GMSServices.provideAPIKey("AIzaSyCaOVKfotVN6tQ4sUbv8ssND-4zmssrdPk")
        GMSPlacesClient.provideAPIKey("AIzaSyCaOVKfotVN6tQ4sUbv8ssND-4zmssrdPk")
        GIDSignIn.sharedInstance().clientID = "184896964264-b63cc2k5vflfup3jfr2moi1j3tb7r705.apps.googleusercontent.com"
        #endif
        
        configureFirebase()
    }
    
    func setUpStatusBar() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
        statusBar.backgroundColor = AppColor.red
    }
    
    private func configureFirebase() {
        #if APPSTORE
        let googleServiceFile = "GoogleService-Prod-Info"
        #else
        let googleServiceFile = "GoogleService-Dev-Info"
        #endif
        
        let filePath = Bundle.main.path(forResource: googleServiceFile, ofType: "plist")!
        guard let options = FirebaseOptions(contentsOfFile: filePath) else {
            print("There are some problems with GoogleService-Info file")
            return
        }
        
        FirebaseApp.configure(options: options)
        
        
    }
}
