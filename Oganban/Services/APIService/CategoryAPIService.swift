//
//  CategoryAPIService.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

protocol CategoryAPIServiceProtocol {
    func getCategory(success: @escaping SuccessHandler<CategoryEntity>.array, failure: @escaping RequestFailure)
    func getCategoryChild(categoryId: String, success: @escaping SuccessHandler<CategoryEntity>.array, failure: @escaping RequestFailure)
    func getCategoryMerge(success: @escaping SuccessHandler<CategoryMergeEntity>.array, failure: @escaping RequestFailure)
    func filterRecord(param: RecordParam, success: @escaping SuccessHandler<RecordEntity>.array, failure: @escaping RequestFailure)
    func getPositionRange(success: @escaping SuccessHandler<PositionRangeEntity>.array, failure: @escaping RequestFailure)
}

class CategoryAPIService: CategoryAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getCategory(success: @escaping SuccessHandler<CategoryEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = CategoryEndPoint.getCategory()
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getCategoryChild(categoryId: String, success: @escaping SuccessHandler<CategoryEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = CategoryEndPoint.getCategoryChild(categoryId: categoryId)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getCategoryMerge(success: @escaping SuccessHandler<CategoryMergeEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = CategoryEndPoint.getCategoryMerge()
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func filterRecord(param: RecordParam, success: @escaping SuccessHandler<RecordEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = CategoryEndPoint.filterRecord(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getPositionRange(success: @escaping SuccessHandler<PositionRangeEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = CategoryEndPoint.getPositionRange()
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
}
