//
//  UtilUsers.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit


class UserUtils: NSObject {
    
    static func saveUser(user: UserEntity) {
        UserDefaultHelper.shared.loginUserInfo = user
        
        if !user.jwt&.isEmpty {
            UserDefaultHelper.shared.userToken = user.jwt&
        }
    }
    
    static func clearLogin(){
        UserDefaultHelper.shared.loginUserInfo = nil
        UserDefaultHelper.shared.userToken = ""
        
        let userPreference : UserDefaults = UserDefaults.standard
        userPreference.removeObject(forKey: UserDefaultHelperKey.userToken.rawValue)
        userPreference.removeObject(forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
    }
}
