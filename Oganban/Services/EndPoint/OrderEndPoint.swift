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
    case changeStatusOrderBuyer(status: OrderStatusKey, orderId: String)
    case changeStatusOrderSaler(status: OrderStatusKey, orderId: String)
    case bookingOrder(recordID: String, price: Double, quantity: Int, paymentType: String, isService: Bool)
    case getHistoryCoin(offset: Int, limit: Int)
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
        case .changeStatusOrderBuyer:
            return "_api/order/post_confirm_order_buyer"
        case .changeStatusOrderSaler:
            return "_api/order/post_confirm_order_seller"
        case .bookingOrder:
            return "_api/order/booking_order"
        case .getHistoryCoin:
            return "/_api/order/get_history_coin"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getTransactionSeller, .getHistoryOrder, .changeStatusOrderBuyer, .changeStatusOrderSaler, .bookingOrder, .getHistoryCoin:
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
        case .changeStatusOrderBuyer(let status, let id):
            return [
                "status": "\(status.rawValue)",
                "order_id": "\(id)"
            ]
        case .changeStatusOrderSaler(let status, let id):
            return [
                "status": "\(status.rawValue)",
                "order_id": "\(id)"
            ]
        case .bookingOrder(let recordID, let price, let quantity, let paymentType, let isService):
            let param = [
                "record_id": recordID,
                "price": price,
                "quantity": quantity,
                "payment_type": paymentType,
                "is_service": isService
            ] as [String: Any]
            return param
        case .getHistoryCoin(let offset, let limit):
            return [
                "offset": offset,
                "limit": limit
            ]
        }
        
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    }
