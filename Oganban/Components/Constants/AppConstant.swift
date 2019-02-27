//
//  AppConstant.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

struct AppConstant {
    #if APPSTORE
    static let appAdmobId = "ca-app-pub-9353872959466378~7688554039"
    static let admobNativeAds = "ca-app-pub-8064036299806325/9836354585"//"ca-app-pub-8064036299806325/9836354585"
    static let admobBanner = "ca-app-pub-9353872959466378/9696658328"
    #else
    static let appAdmobId = "ca-app-pub-8064036299806325~8781055145"
    static let admobNativeAds = "ca-app-pub-3940256099942544/3986624511"
    static let admobBanner = "ca-app-pub-3940256099942544/2934735716"
    #endif
    
    static let notiDidUpdateSocial = NSNotification.Name.init("didUpdateSocial")
    static let notiReloadMoreView = NSNotification.Name.init("notiReloadMoreView")
    
    static let deleteSubComment = NSNotification.Name.init("deleteSubComment")
    static let deleteComment = NSNotification.Name.init("deleteComment")
    static let loadDataLogin = NSNotification.Name.init("loadDataLogin")
    static let moneyToCoint: Double = 20000
}
