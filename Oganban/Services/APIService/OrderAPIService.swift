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
    func getHistoryOrder(status: String, limit: Int, offset: Int, success: @escaping SuccessHandler<BaseOrderEntity>.object, failure: @escaping RequestFailure)
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
    
    func getHistoryOrder(status: String, limit: Int, offset: Int, success: @escaping SuccessHandler<BaseOrderEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = OrderEndPoint.getHistoryOrder(status: status, offset: offset, limit: limit)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
