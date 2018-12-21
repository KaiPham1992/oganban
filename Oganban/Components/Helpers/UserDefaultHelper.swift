//
//  UserDefaultHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//
import UIKit
import GoogleMaps

enum UserDefaultHelperKey: String {
    case deviceToken = "DeviceToken"
    case fcmToken = "FcmToken"
    case lat = "LatUser"
    case long = "LongUser"
    case userToken = "UserToken"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard
    
    
    var userToken: String? {
        get {
            let value = get(key: .userToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .userToken)
        }
    }
    
    var fcmToken: String? {
        get {
            let value = get(key: .fcmToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .fcmToken)
        }
    }
    
    var deviceToken: String? {
        get {
            let value = get(key: .deviceToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .deviceToken)
        }
    }
    
    var isLoggedIn: Bool {
        guard let _token = userToken else { return false }
        return !_token.isEmpty
    }
}

extension UserDefaultHelper {
    private func save(value: Any?, key: UserDefaultHelperKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }
    
    private func get(key: UserDefaultHelperKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
    
    private func saveLocation(lat: CLLocationDegrees, long: CLLocationDegrees) {
        save(value: lat, key: .lat)
        save(value: long, key: .long)
    }
    
    private func getLocation() -> CLLocationCoordinate2D? {
        guard let lat = get(key: .lat) as? CLLocationDegrees else { return nil}
        guard let long = get(key: .long) as? CLLocationDegrees else { return nil }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
