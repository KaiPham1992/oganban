//
//  CategoryEndPoint.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Alamofire

enum CategoryEndPoint {
    case getCategory()
}

extension CategoryEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getCategory:
            return "_api/category/get_category"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCategory:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getCategory:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
