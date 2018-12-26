//
//  UserEndPoint.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

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
    case addFavoriteStaff(type: String, staffID: String)
}

extension UserEndPoint: EndPointType {
    var path: String {
        switch self {
        case .login(_, _):
            return "_api/user/login"
        case .fogotPassword(_):
            return "_api/user/forgot_password"
        case .checkLogin():
            return "user/check_login"
        case .getCaptcha:
            return "_api/user/get_captcha"
        case .logout:
            return "user/logout"
        case .loginGmail, .loginFacebook:
            return "user/login_social"
        case .signUp:
            return "_api/user/register"
        case .changePassword:
            return "user/change_password"
        case .updateProfile:
            return "_api/user/update_profile"
        case .verifyPhone:
            return "user/verify_phone"
        case .getListFavorite:
            return "user/favorite_list"
        case .getIntroduceList:
            return "user/introduce_list"
        case .getPointHistory:
            return "point/point_list_log"
        case .addFavorite, .addFavoriteStaff:
            return "user/add_favorite"
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .fogotPassword, .checkLogin, .logout, .loginGmail, .loginFacebook, .verifyPhone, .getPointHistory, .getListFavorite, .addFavorite, .addFavoriteStaff, .signUp:
            return .post
        case .getCaptcha, .getIntroduceList:
            return .get
        case .changePassword, .updateProfile:
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
            return [:]
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
            let param = ["current_password": current,
                         "new_password": new] as [String: Any]
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
        case .addFavoriteStaff(let type, let staffID):
            let param = ["type": type,
                         "sale_id": staffID] as [String: Any]
            return param
        }
    }
    
    var headers: HTTPHeaders? {
        var header = DefaultHeader().addAuthHeader()
        header["Type"] = "client"
        return header
    }
}
