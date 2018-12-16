//
//  LanguageHelper.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation

import Foundation


let APPLE_LANGUAGE_KEY = "AppleLanguages"

enum LanguageType: String {
    case vietname = "vi"
    case english = "en"
}

class LanguageHelper {
    
    //get current apple language
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current.substring(to: current.index(endIndex, offsetBy: 2))
        
        return currentWithoutLocale
    }
    
    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    // set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: LanguageType) {
        let userdef = UserDefaults.standard
        userdef.set([lang.rawValue,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
        
        Bundle.setLanguage(lang.rawValue)
    }
    
    class func getCurrentBundle() -> Bundle {
        let currentLanguage = LanguageHelper.currentAppleLanguage()
        if let _path = Bundle.main.path(forResource: LanguageHelper.currentAppleLanguageFull(), ofType: "lproj") {
            return Bundle(path: _path)!
        } else
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                return Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                return  Bundle(path: _path)!
        }
    }
}
