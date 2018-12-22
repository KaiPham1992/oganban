//
//  AppString.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//
import Foundation

struct TitleString {
    //-- sign up
    static let loginName             = "Tên đăng nhập*"
    static let placeHolderLoginName  = "Nhập địa chỉ email"
    static let email                = "Nhập lại email*"
    static let placeHolderEmail     = "Nhập lại địa chỉ email"
    static let displayName             = "Tên hiển thị*"
    static let placeHolderDisplayName  = "Nhập tên hiển thị"
    static let birthday                = "Ngày tháng năm sinh*"
    static let placeHolderBirthday     = "Chọn ngày"
    static let gender                = "Giới tính"
    static let placeHolderGender     = "Chọn giới tính"
    static let houseAddress             = "Địa chỉ 1"
    static let placeHolderHouseAddress  = "Bạn có thể nhập địa chỉ nhà"
    static let companyAddress                = "Địa chỉ 2"
    static let placeHolderCompanyAddress     = "Bạn có thể nhập địa chỉ công ty"
    static let introduce             = "Mã người giới thiệu"
    static let placeHolderIntroduce = "Nhập mã người giới thiệu nếu có"
    static let password             = "Mật khẩu*"
    static let placeHolderPassword  = "Nhập mật khẩu"
    static let confirm              = "Nhập lại mật khẩu*"
    static let placeHolderConfirm   = "Nhập lại mật khẩu"
    static let captcha              = "Mã captcha*"
    static let placeHolderCaptcha   = "Nhập mã captcha"
    
    static let phonePlaceHolder     = "phonePlaceHolder"
    static let passwordLogin        = "passwordLogin"
    static let emailOrPhone         = "emailOrPhone"
    static let fullNamePlaceHolder             = "fullNamePlaceHolder"
    static let fullName            = "fullName"
    static let addressOrther        = "addressOrther"
    static let addressOrtherPlaceHolder        = "addressOrtherPlaceHolder"
    static let searchTVVInMap = "SearchInMap"
    static let searchProjectInMap = "SearchProjectInMap"
    static let markReadAll = "MarkReadAll"
    
}

struct MessageString {
    static let notEnoughCoin = "Số Ơcoin tích lũy của bạn không đủ để đổi sản phẩm. Vui lòng kiểm tra lại !"
}

struct Params {
    static let appId = "app_id"
    static let appName = "app_name"
    static let appVersion = "app_version"
    static let deviceId = "device_id"
    static let deviceName = "device_name"
    static let deviceVersion = "device_version"
    
    static let appleToken = "apple_token"
    static let firebaseToken = "firebase_token"
    static let phonecode = "phone_code"
    static let timezone = "timezone"
    
    static let lat = "lat"
    static let long = "long"
}

struct App {
    struct key {
        static let saveBadgeNum = "constantSaveBadgeNum"
        static let userId = "UserDefaultsUserId"
        static let userImage = "UserDefaultsUserImage"
        static let userName = "UserDefaultsUserName"
        static let userFullName = "UserDefaultsUserFullName"
        static let phone = "UserDefaultsUserPhone"
        static let userLoginType = "UserDefaultsUserLoginType"
        static let appToken = "UserDefaultsJWT"
        static let email = "UserDefaultsEmail"
        static let language = "UserDefaultsLanguage"
        static let point = "UserDefaultsPoint"
        static let rankName = "UserDefaultsRankName"
    }
}

struct AppString {
    static let contractPurchase = "ContractPurchase"
    static let contractFirst = "ContractFirst"
    static let contractSecond = "ContractSecond"
}

struct LoadMore {
    static let limit = 20
}


