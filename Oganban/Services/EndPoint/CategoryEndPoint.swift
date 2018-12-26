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
    case getCategoryChild(categoryId: String)
}

extension CategoryEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getCategory:
            return "_api/category/get_category"
        case .getCategoryChild:
            return "_api/category/get_category_child"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCategory, .getCategoryChild:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getCategory:
            return [:]
        case .getCategoryChild(let categoryId):
            return ["category_id": categoryId]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
