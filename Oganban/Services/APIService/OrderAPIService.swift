//
//  OrderAPIService.swift
//  Oganban
//
//  Created by Coby on 1/3/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation

protocol OrderAPIServiceProtocol {
    func getTransactionSeller(status: String, limit: Int, offset: Int, success: @escaping SuccessHandler<BaseOrderEntity>.object, failure: @escaping RequestFailure)
    
    func getDetailOrder(id: String, success: @escaping SuccessHandler<OrderDetailEntity>.object, failure: @escaping RequestFailure)

    func getHistoryOrder(status: String, limit: Int, offset: Int, success: @escaping SuccessHandler<BaseOrderEntity>.object, failure: @escaping RequestFailure)
    
    func changeStatusOrderBuyer(status: OrderStatusKey, id: String, success: @escaping SuccessHandler<OrderDetailEntity>.object, failure: @escaping RequestFailure)
    
   func changeStatusOrderSaler(status: OrderStatusKey, id: String, success: @escaping SuccessHandler<OrderDetailEntity>.object, failure: @escaping RequestFailure)
    func bookingOrder(recordID: String, price: Double, quantity: Int, paymentType: String, isService: Bool, success: @escaping SuccessHandler<OrderEntity>.object, failure: @escaping RequestFailure)
}

class OrderAPIService: OrderAPIServiceProtocol {
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    func getTransactionSeller(status: String, limit: Int, offset: Int, success: @escaping SuccessHandler<BaseOrderEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.getTransactionSeller(status: status, limit: limit, offset: offset)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    

    func getDetailOrder(id: String, success: @escaping SuccessHandler<OrderDetailEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.getDetailOrder(id: id)
         network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

    func getHistoryOrder(status: String, limit: Int, offset: Int, success: @escaping SuccessHandler<BaseOrderEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.getHistoryOrder(status: status, offset: offset, limit: limit)

        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusOrderBuyer(status: OrderStatusKey, id: String, success: @escaping SuccessHandler<OrderDetailEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.changeStatusOrderBuyer(status: status, orderId: id)
        
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusOrderSaler(status: OrderStatusKey, id: String, success: @escaping SuccessHandler<OrderDetailEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.changeStatusOrderSaler(status: status, orderId: id)
        
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func bookingOrder(recordID: String, price: Double, quantity: Int, paymentType: String, isService: Bool, success: @escaping SuccessHandler<OrderEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.bookingOrder(recordID: recordID, price: price, quantity: quantity, paymentType: paymentType, isService: isService)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
}
