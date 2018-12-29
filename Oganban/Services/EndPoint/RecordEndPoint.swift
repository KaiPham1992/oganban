//
//  RecordEndPoint.swift
//  Oganban
//
//  Created by Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import Alamofire

enum RecordEndPoint {
    case getRecordSellerPost(status: String, offset: Int, limit: Int)
    case getRecordDetail(id: Int)
}

extension RecordEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getRecordSellerPost:
            return "_api/record/get_record_seller_post"
        case .getRecordDetail(let id):
            return "_api/record/get_record_detail/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecordSellerPost:
            return .post
        case .getRecordDetail:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getRecordSellerPost(let status, let offset, let limit):
            let param = ["status": status,
                         "offset": offset,
                         "limit": limit] as [String: Any]
            return param
        case .getRecordDetail:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
