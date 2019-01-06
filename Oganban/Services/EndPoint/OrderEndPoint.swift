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
    case getDetailOrder(id: String)
    case getHistoryOrder(status: String, offset: Int, limit: Int)
}

extension OrderEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getTransactionSeller:
            return "_api/order/get_transaction_seller"
        case .getDetailOrder(let id):
            return "_api/order/order_detail/\(id)"
        case .getHistoryOrder:
            return "_api/order/get_history_orders"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTransactionSeller, .getHistoryOrder:
            return .post
        case .getDetailOrder:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getTransactionSeller(let status, let limit, let offset):
            let param = ["status": status,
                         "limit": limit,
                         "offset": offset] as [String: Any]
            return param
        case .getDetailOrder:
            return [:]
        case .getHistoryOrder(let status, let offset, let limit):
            let param = ["status": status,
                         "offset": offset,
                         "limit": limit] as [String: Any]
            return param
        }
        
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    }
