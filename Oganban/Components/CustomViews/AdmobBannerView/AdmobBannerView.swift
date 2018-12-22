//
//  AdmobBannerView.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdmobBannerView: GADBannerView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        guard let topVC = UIApplication.topViewController() else { return }
        adUnitID = AppConstant.admobBanner
        rootViewController = topVC
        load(GADRequest())
    }
}
