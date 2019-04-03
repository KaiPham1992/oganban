//
//  AdmobBannerView.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdmobBannerView: BaseViewXib, GADBannerViewDelegate {
    @IBOutlet weak var vAdsGoogle: GADBannerView!
    
    override func setUpViews() {
        super.setUpViews()
        vAdsGoogle.loadAds()
        vAdsGoogle.delegate = self
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error.debugDescription)
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("OK")
    }
    
}
