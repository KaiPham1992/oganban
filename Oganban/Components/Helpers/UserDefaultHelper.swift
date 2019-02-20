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
    case loginUserInfo = "LoginUserInfo"
    case deviceToken = "DeviceToken"
    case fcmToken = "FcmToken"
    case lat = "LatUser"
    case long = "LongUser"
    case address = "Address"
    case userToken = "UserToken"
    case email = "email"
    case radius = "radius"
    case coin = "coin"
    case loginSocial = "loginSocial"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard
    
    var loginUserInfo: UserEntity? {
        get {
            if let savedUser = UserDefaults.standard.object(forKey: UserDefaultHelperKey.loginUserInfo.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(UserEntity.self, from: savedUser) {
                    return user
                }
            }
            return nil
        }
        set(loginUserInfo) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(loginUserInfo) {
                UserDefaults.standard.set(encoded, forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
            }
        }
    }
    
    var userToken: String? {
        get {
            let value = get(key: .userToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .userToken)
        }
    }
    
    var coin: Double? {
       
        return loginUserInfo?.coin
    }
    
    var loginSocial: String? {
        
        return loginUserInfo?.socialType
    }
    
    var emailUser: String? {
        get {
            let value = get(key: .email) as? String
            return value
        }
        set(email) {
            save(value: email, key: .email)
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
    
    var isSocialLogin: Bool {
        return  loginUserInfo?.socialImage != nil 
    }
    
    var lat: String {
        guard let _lat = get(key: .lat) as? CLLocationDegrees else { return ""}
        return _lat.description
    }
    
    var long: String {
        guard let _lat = get(key: .long) as? CLLocationDegrees else { return ""}
        return _lat.description
    }
    
    var address: String {
        guard let _lat = get(key: .address) as? String else { return ""}
        return _lat
    }
    
    var radius: PositionRangeEntity? {
        get {
            if let savedUser = UserDefaults.standard.object(forKey: UserDefaultHelperKey.radius.rawValue) as? Data {
                let decoder = JSONDecoder()
                if let _radius = try? decoder.decode(PositionRangeEntity.self, from: savedUser) {
                    return _radius
                }
            }
            return PositionRangeEntity(JSON: ["_id": "8", "_value": ""])
        }
        set(radius) {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(radius) {
                UserDefaults.standard.set(encoded, forKey: UserDefaultHelperKey.radius.rawValue)
            }
        }
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
    
    func saveLocation(lat: CLLocationDegrees, long: CLLocationDegrees, address: String) {
        save(value: lat, key: .lat)
        save(value: long, key: .long)
        save(value: address, key: .address)
    }
    
    private func getLocation() -> CLLocationCoordinate2D? {
        guard let lat = get(key: .lat) as? CLLocationDegrees else { return nil}
        guard let long = get(key: .long) as? CLLocationDegrees else { return nil }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
