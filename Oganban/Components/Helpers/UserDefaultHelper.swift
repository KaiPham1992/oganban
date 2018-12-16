//
//  UserDefaultHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import GoogleMaps

enum UserDefaultHelperKey: String {
    case lat = "LatUser"
    case long = "LongUser"
    case deviceToken = "DeviceToken"
    case fcmToken = "FcmToken"
    case userId = "UserDefaultsUserId"
    case userImage = "UserDefaultsUserImage"
    case userName = "UserDefaultsUserName"
    case userFullName = "UserDefaultsUserFullName"
    case phone = "UserDefaultsUserPhone"
    case userLoginType = "UserDefaultsUserLoginType"
    case appToken = "UserDefaultsJWT"
    case email = "UserDefaultsEmail"
    case language = "UserDefaultsLanguage"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    let userDefaultManager = UserDefaults.standard
    
    func save(value: Any?, key: UserDefaultHelperKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }
    
    func get(key: UserDefaultHelperKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
    
    func saveLocation(lat: CLLocationDegrees, long: CLLocationDegrees) {
        save(value: lat, key: .lat)
        save(value: long, key: .long)
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        guard let lat = get(key: .lat) as? CLLocationDegrees else { return nil}
        guard let long = get(key: .long) as? CLLocationDegrees else { return nil }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}
