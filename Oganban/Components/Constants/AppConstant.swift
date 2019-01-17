//
//  AppConstant.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

struct AppConstant {
    static let admobNativeAds = "ca-app-pub-3940256099942544/3986624511"
    static let admobBanner = "ca-app-pub-3940256099942544/2934735716"
    
    static let notiDidUpdateSocial = NSNotification.Name.init("didUpdateSocial")
    static let notiReloadMoreView = NSNotification.Name.init("notiReloadMoreView")
    
    static let deleteSubComment = NSNotification.Name.init("deleteSubComment")
    static let deleteComment = NSNotification.Name.init("deleteComment")
    
    static let moneyToCoint: Double = 20000
}
