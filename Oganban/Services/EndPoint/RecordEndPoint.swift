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
    case getRecordDetail(id: String)
    case hideRecord(recordID: Int)
    case postRecord(param: PostRecordParam)
}

extension RecordEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getRecordSellerPost:
            return "_api/record/get_record_seller_post"
        case .getRecordDetail(let id):
            return "_api/record/get_record_detail/\(id)"
        case .hideRecord:
            return "_api/record/hide_record"
        case .postRecord:
            return "_api/record/add_record"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecordSellerPost, .postRecord:
            return .post
        case .getRecordDetail:
            return .get
        case .hideRecord:
            return .put
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
        case .hideRecord(let recordID):
            let param = ["record_id": recordID]
            return param
        case .postRecord(let param):
            return param.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
