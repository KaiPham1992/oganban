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
        GADMobileAds.configure(withApplicationID: AppConstant.appAdmobId)
        
        // get key from fire base : AIzaSyCaOVKfotVN6tQ4sUbv8ssND
        #if APPSTORE
        GMSServices.provideAPIKey("AIzaSyB5SWRz9NmcGfr-i9cSZKZp5Qzc4uhC9EE")
        GMSPlacesClient.provideAPIKey("AIzaSyB5SWRz9NmcGfr-i9cSZKZp5Qzc4uhC9EE")
        GIDSignIn.sharedInstance().clientID = "75482666365-r238vl3vtgahphqk7suf0o18j31b02ru.apps.googleusercontent.com"
        #else
        GMSServices.provideAPIKey("AIzaSyCaOVKfotVN6tQ4sUbv8ssND-4zmssrdPk")
        GMSPlacesClient.provideAPIKey("AIzaSyCaOVKfotVN6tQ4sUbv8ssND-4zmssrdPk")
        GIDSignIn.sharedInstance().clientID = "75482666365-hu68btcpb6hks79npv4npjad2t4rla0o.apps.googleusercontent.com"
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
