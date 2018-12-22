//
//  AdmobNativeView.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdmobNativeView: BaseViewXib {
    
    @IBOutlet weak var vAdsGoogle: GADUnifiedNativeAdView!
    var adLoader: GADAdLoader!
    
    override func setUpViews() {
        super.setUpViews()
        
        guard let topVC = UIApplication.topViewController() else { return }
        
        adLoader = GADAdLoader(adUnitID: AppConstant.admobNativeAds, rootViewController: topVC, adTypes: [ .unifiedNative ], options: nil)
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
}

extension AdmobNativeView: GADUnifiedNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        vAdsGoogle.nativeAd = nativeAd
//        nativeAd.delegate = self
    }
}

// MARK: - GADUnifiedNativeAdDelegate implementation
//extension AdmobNativeView : GADUnifiedNativeAdDelegate {
//
//    func nativeAdDidRecordClick(_ nativeAd: GADUnifiedNativeAd) {
//        print("\(#function) called")
//    }
//
//    func nativeAdDidRecordImpression(_ nativeAd: GADUnifiedNativeAd) {
//        print("\(#function) called")
//    }
//
//    func nativeAdWillPresentScreen(_ nativeAd: GADUnifiedNativeAd) {
//        print("\(#function) called")
//    }
//
//    func nativeAdWillDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
//        print("\(#function) called")
//    }
//
//    func nativeAdDidDismissScreen(_ nativeAd: GADUnifiedNativeAd) {
//        print("\(#function) called")
//    }
//
//    func nativeAdWillLeaveApplication(_ nativeAd: GADUnifiedNativeAd) {
//        print("\(#function) called")
//    }
//}

