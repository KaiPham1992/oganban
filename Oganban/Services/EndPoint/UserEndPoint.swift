//
//  UserEndPoint.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//
import UIKit
import Alamofire
import ObjectMapper

enum UserEndPoint {
    case login(email: String, password: String)
    case fogotPassword(email: String)
    case checkLogin()
    case getCaptcha()
    case logout()
    case loginGmail(loginSocialParam: LoginSocialParam)
    case loginFacebook(fbEntity: FacebookEntity, phone: String)
    case signUp(param: SignUpParam)
    case changePassword(current: String, new: String)
    case updateProfile(param: UserEntity)
    case verifyPhone(code: String, phone: String, phoneCode: String)
    case getListFavorite(type: String, offset: Int, limit: Int)
    
    case getIntroduceList()
    case getPointHistory()
    case addFavorite(type: String, projectId: String)
    case addFavoriteStaff(isFavorite: Bool, accountID: String)
    
    case updateProfileSocial(param: UpdateProfileSocial)
    case uploadAvatar()
    

    case getHistoryCoin()
    case postRating(point: Int, accountID: String, isBuyer: Bool, orderID: String)
    
    case getHistoryBuy(offset: Int, limit: Int)
    case getFavourite(offset: Int, limit: Int)
    case addRemoveFavourite(isFavorite: Int, accountId: Int)
}

extension UserEndPoint: EndPointType {
    var path: String {
        switch self {
        case .login(_, _):
            return "_api/user/login"
        case .fogotPassword(_):
            return "_api/user/forgot_password"
        case .checkLogin():
            return "_api/user/check_login"
        case .getCaptcha:
            return "_api/user/get_captcha"
        case .logout:
            return "_api/user/logout"
        case .loginGmail, .loginFacebook:
            return "_api/user/login_social"
        case .signUp:
            return "_api/user/register"
        case .changePassword:
            return "_api/user/change_password"
        case .updateProfile:
            return "_api/user/update_profile"
        case .verifyPhone:
            return "_api/user/verify_phone"
        case .getListFavorite:
            return "_api/user/favorite_list"
        case .getIntroduceList:
            return "_api/user/introduce_list"
        case .getPointHistory:
            return "_api/point/point_list_log"
        case .addFavorite, .addFavoriteStaff:
            return "_api/user/add_favorite"
        case .updateProfileSocial:
            return "_api/user/update_profile_social"
        case .uploadAvatar:
            return "_api/user/upload_avatar"
        case .getHistoryBuy:
            return "_api/user/get_history_buy_post"
        case .getFavourite:
            return "_api/user/favourite"
        case .postRating:
            return "_api/user/post_rating"
        case .addRemoveFavourite:
            return "_api/user/add_favorite"
        case .getHistoryCoin:
            return "_api/order/get_history_coin"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        switch self { case .login, .fogotPassword, .checkLogin, .logout, .loginGmail, .loginFacebook, .verifyPhone, .getPointHistory, .getListFavorite, .addFavorite, .addFavoriteStaff, .signUp, .uploadAvatar, .postRating, .getFavourite, .getHistoryBuy, .addRemoveFavourite, .getHistoryCoin:
            return .post
        case .getCaptcha, .getIntroduceList:
            return .get
        case .changePassword, .updateProfile, .updateProfileSocial:
            return .put
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .login(let email, let password):
            var param = ["email": email,
                         "password": password] as [String: Any]
            param = BaseParam.addDeviceParams(inputParams: param)
            return param
        case .fogotPassword(let email):
            return ["email": email]
        case .checkLogin():
            var param = [:] as [String: Any]
            param = BaseParam.addDeviceParams(inputParams: param)
            return param
        case .getCaptcha:
            return [:]
        case .logout:
            var param = [:] as [String: Any]
            param = BaseParam.addDeviceParams(inputParams: param)
            return param
        case .loginGmail(let param):
            let newParam = BaseParam.addDeviceParams(inputParams: param.toJSON())
            return newParam
        case .loginFacebook(let fbEntity, let phone):
            var newParm = fbEntity.toJSON()
            newParm = BaseParam.addDeviceParams(inputParams: newParm)
            newParm["phone_number"] = phone
            return newParm
        case .signUp(let param):
            let params = BaseParam.addDeviceParams(inputParams: param.toJSON())
            return params
        case .changePassword(let current, let new):
            var param = ["current_password": current,
                         "new_password": new] as [String: Any]
            param = BaseParam.addDeviceParams(inputParams: param)
            return param
        case .updateProfile(let param):
            let param = ["fullname": param.fullName ?? "",
                         "phone_number": param.phone ?? "",
                         "phone_code": param.phoneCode ?? "",
                         "birthday": param.birthday ?? "",
                         "gender": param.gender ?? "",
                         "address_1": param.houseAddress ?? "",
                         "address_2": param.companyAddress ?? ""] as [String: Any]
            return param
        case .verifyPhone(let code, let phone, let phoneCode):
            let param = ["code_verify": code,
                         "phone_number": phone,
                         "phone_code": phoneCode] as [String: Any]
            return param
        case .getListFavorite(let type, let offset, let limit):
            let param = ["type": type,
                         "offset": offset,
                         "limit": limit] as [String: Any]
            return param
        case .getIntroduceList:
            return [:]
        case .getPointHistory:
            return [:]
        case .addFavorite(let type, let projectId):
            let param = ["type": type,
                         "project_id": projectId] as [String: Any]
            return param
        case .addFavoriteStaff(let isFavorite, let accountID):
            let param = ["is_favorite": isFavorite,
                         "account_id": accountID] as [String: Any]
            return param
        case .postRating(let point, let accountID, let isBuyer, let orderID):
            let param = ["point": point,
                         "account_id": accountID,
                         "is_buyer": isBuyer,
                         "order_id": orderID] as [String: Any]
            return param
        case .updateProfileSocial(let param):
            return param.toJSON()
        case .uploadAvatar:
            return [:]
        case .getHistoryCoin:
            return [:]
        case .getHistoryBuy(let offset, let limit):
            return ["offset": offset,
                    "limit": limit]
        case .getFavourite(let offset, let limit):
            return  ["offset": offset,
                     "limit": limit]
        case .addRemoveFavourite(let isFavorite, let accountId):
            return ["is_favorite": isFavorite,
                    "account_id": accountId]
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .updateProfileSocial:
            var header: [String: String] = ["Content-Type": "application/json"]
            header["Authorization"] = "Bearer " + DataManager.shared.tempToken
            return header
        default:
            var header = DefaultHeader().addAuthHeader()
            header["Type"] = "client"
            return header
        }
        
    }
}
