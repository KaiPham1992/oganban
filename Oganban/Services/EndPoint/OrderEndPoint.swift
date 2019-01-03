//
//  OrderEndPoint.swift
//  Oganban
//
//  Created by Coby on 1/3/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Alamofire

enum OrderEndPoint {
    case getTransactionSeller(status: String, limit: Int, offset: Int)
}

extension OrderEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getTransactionSeller:
            return "_api/order/get_transaction_seller"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTransactionSeller:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getTransactionSeller(let status, let limit, let offset):
            let param = ["status": status,
                         "limit": limit,
                         "offset": offset] as [String: Any]
            return param
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    }
