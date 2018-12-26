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
        if !user.jwt&.isEmpty {
            UserDefaultHelper.shared.userToken = user.jwt&
        }
    }
    
//    static  func  hashPassword(password: String) -> String {
//        return password.sha256();
//    }
//
//    static func saveLogin(user: UserEntity){
//        DataManager.shared().loginedUser = user
//
//        let userPreference : UserDefaults = UserDefaults.standard
//        userPreference.set(user.id, forKey: App.key.userId)
//
//        if(user.jwt != nil && (user.jwt!.trim().count > 0)){
//            //            userPreference.set(user.jWT, forKey: App.key.appToken)
////            saveToken()
//            userPreference.set(user.jwt, forKey: App.key.appToken)
////            KeychainManager.shared.saveToken(token: user.jWT&)
//        }
//        userPreference.set(user.userName, forKey: App.key.userName)
//        userPreference.set(user.fullName, forKey: App.key.userFullName)
//        userPreference.set(user.email, forKey: App.key.email)
//        userPreference.set(user.phone, forKey: App.key.phone)
//        userPreference.set(user.point2rank, forKey: App.key.point)
//        userPreference.set(user.rankName, forKey: App.key.rankName)
//        userPreference.synchronize
//
//    }
//
//
//    static func clearLogin(){
//        DataManager.shared().loginedUser = nil
//
//        let userPreference : UserDefaults = UserDefaults.standard
//        userPreference.removeObject(forKey: App.key.userId)
//        userPreference.removeObject(forKey: App.key.userName)
//        userPreference.removeObject(forKey: App.key.userFullName)
//        userPreference.removeObject(forKey: App.key.appToken)
//        userPreference.removeObject(forKey: App.key.userImage)
//        userPreference.removeObject(forKey: App.key.rankName)
//        userPreference.removeObject(forKey: App.key.point)
//        userPreference.synchronize()
////        KeychainManager.shared.deleteToken()
//    }
//
//    static func get(key: String) -> String? {
//        let userPreference : UserDefaults = UserDefaults.standard
//        return userPreference.value(forKey: key) as? String
//    }
//
//    static func getLoginToken() -> String?{
//        let userPreference : UserDefaults = UserDefaults.standard
//        return userPreference.value(forKey: App.key.appToken) as? String
//    }
//
//    static func saveToken() {
//        let userDefault : UserDefaults = UserDefaults.standard
//        userDefault.set(true, forKey: App.key.appToken)
//    }
//
//    static func checkSaveToken() -> Bool {
//        let userDefault : UserDefaults = UserDefaults.standard
//        return userDefault.bool(forKey: App.key.appToken)
//    }
}
