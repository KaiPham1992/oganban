//
//  GADBannerView+extension.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import GoogleMobileAds

extension GADBannerView {
    func loadAds() {
        guard let topVC = UIApplication.topViewController() else { return }
        rootViewController = topVC
        adUnitID = AppConstant.admobBanner
        
        load(GADRequest())
    }
}

