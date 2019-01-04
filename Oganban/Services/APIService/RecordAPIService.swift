//
//  RecordAPIService.swift
//  Oganban
//
//  Created by Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

protocol RecordAPIServiceProtocol {
    func getRecordSellerPost(status: String, offset: Int, limit: Int, success: @escaping SuccessHandler<BaseRecordEntity>.object, failure: @escaping RequestFailure)
    func getRecordDetail(id: String, success: @escaping SuccessHandler<RecordEntity>.object, failure: @escaping RequestFailure)
    func hideRecord(recordID: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func postRecord(param: PostRecordParam, success: @escaping SuccessHandler<RecordEntity>.object, failure: @escaping RequestFailure)
    
}

class RecordAPIService: RecordAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getRecordDetail(id: String, success: @escaping SuccessHandler<RecordEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.getRecordDetail(id: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getRecordSellerPost(status: String, offset: Int, limit: Int, success: @escaping SuccessHandler<BaseRecordEntity>.object, failure: @escaping (APIError?) -> Void) {
        let endPoint = RecordEndPoint.getRecordSellerPost(status: status, offset: offset, limit: limit)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func hideRecord(recordID: Int, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.hideRecord(recordID: recordID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func postRecord(param: PostRecordParam, success: @escaping SuccessHandler<RecordEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.postRecord(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
}
