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
    static let loginName             = "Tên đăng nhập *"
    static let placeHolderLoginName  = "Nhập địa chỉ email"
    static let email                = "Nhập lại email *"
    static let placeHolderEmail     = "Nhập lại địa chỉ email"
    static let displayName             = "Tên hiển thị *"
    static let placeHolderDisplayName  = "Nhập tên hiển thị"
    static let birthday                = "Ngày tháng năm sinh *"
    static let placeHolderBirthday     = "Chọn ngày"
    static let gender                = "Giới tính"
    static let placeHolderGender     = "Chọn giới tính"
    static let houseAddress             = "Địa chỉ 1"
    static let placeHolderHouseAddress  = "Bạn có thể nhập địa chỉ nhà"
    static let companyAddress                = "Địa chỉ 2"
    static let placeHolderCompanyAddress     = "Bạn có thể nhập địa chỉ công ty"
    static let introduce             = "Mã người giới thiệu"
    static let placeHolderIntroduce = "Nhập mã người giới thiệu nếu có"
    static let password             = "Mật khẩu *"
    static let placeHolderPassword  = "Nhập mật khẩu"
    static let confirm              = "Nhập lại mật khẩu *"
    static let placeHolderConfirm   = "Nhập lại mật khẩu"
    static let captcha              = "Mã captcha *"
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
    static let notification = "Thông báo"
    
}

struct ButtonName {
    static let login = "Đăng nhập"
    static let facebook = "Facebook"
    static let google = "Google"
    static let signup = "Đăng ký"
    static let saveProfile = "Lưu thay đổi"
    static let sendSupplementaryInfo = "Gửi"
}

struct MoreTitle {
    static let historyCoin            = "Lịch sử ƠCoin"
    static let historyBuy             =  "Lịch sử mua tin"
    static let policy                 =  "Điều khoản sử dụng"
    static let tutorial               = "Hướng dẫn"
    static let setting                = "Cài đặt"
    static let changePassword         = "Đổi mật khẩu"
    static let logout                 = "Đăng xuất"
    static let loginSignup            = "Đăng nhập / Đăng ký"
    static let version                = "Version"
    
}

struct MessageString {
    static let notEnoughCoin = "Số Ơcoin tích lũy của bạn không đủ để đổi sản phẩm. Vui lòng kiểm tra lại !"
    static let invalidLoginEmailPassword  = "Vui lòng kiểm tra lại email hoặc mật khẩu"
    static let notVerifyUser  = "Tài khoản chưa được kích hoạt"
    static let emptyUsername = "Vui lòng nhập tên đăng nhập"
    static let checkedUsername =  "Vui lòng kiểm tra lại tên đăng nhập"
    static let emptyDisplayName = "Vui lòng nhập tên hiển thị"
    static let emptyBirthday = "Vui lòng chọn ngày tháng năm sinh"
    static let checkedAge = "Vui lòng kiểm tra lại tuổi phải trên 15"
    static let emptyPhone = "Vui lòng nhập số điện thoại"
    static let checkedPhone =  "Vui lòng kiểm tra lại số điện thoại"
    static let notTickPolicy = "Vui lòng chọn điều khoản sử dụng"
    static let messageEmptyEmail = "Vui lòng nhập email"
    static let messageInvalidEmailFormat = "Email không đúng format"
    static let messageEmailNoHave = "Email này không tồn tại trong hệ thống"
    static let invalidInput = "Vui lòng nhập đầy đủ thông tin"
    static let limitCount = "Mật khẩu phải có 6 kí tự"
    static let invalidConfirmPassword = "Nhập lại mật khẩu không đúng"
    static let invalidCurentPassword = "Mật khẩu không đúng"
}

struct NavigationTitle {
    static let profileInfo = "Thông tin tài khoản"
    static let more = "Xem thêm"
    static let myBuy = "Tôi mua"
    static let mySell = "Tôi bán"
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


