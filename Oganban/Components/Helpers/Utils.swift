//
//  Utils.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit
import Alamofire

class Utils {
    class func estimateHeight(_ width: CGFloat, customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: customFont], context: nil)
        return estimateFrame.height
    }
    
    class func estimateWidth(_ height: CGFloat, customFont: UIFont, str: String) -> CGFloat{
        let size = CGSize(width: 1000, height: height)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: customFont], context: nil)
        return estimateFrame.width
    }
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension Utils {
    class func getMinimumWidthHeight() -> CGFloat {
        return CGFloat.minimum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    class func getMaximumWidthHeight() -> CGFloat {
        return CGFloat.maximum(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    class func isIphoneX() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            return true
        }
        
        return false
    }
    
    class func isLandscape() -> Bool {
        return UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }
}


extension Utils {
    class func getTimeZone() -> String {
        return TimeZone.current.identifier
    }
}
