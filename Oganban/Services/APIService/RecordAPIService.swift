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
    func hideRecord(recordID: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func postRecord(param: PostRecordParam, success: @escaping SuccessHandler<RecordEntity>.object, failure: @escaping RequestFailure)
    func getExpireDateRecord(success: @escaping SuccessHandler<ExpirePostEntity>.object, failure: @escaping RequestFailure)
    func deleteRecord(recordID: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    //--Comment
    func sendComment(param: SendCommentParam, success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure)
    
      func sendSubComment(param: SendCommentParam, success: @escaping SuccessHandler<SubCommentEntity>.object, failure: @escaping RequestFailure)
//    func getCommentList(recordId: String, offset: Int, limit: Int, success: @escaping SuccessHandler<CommentResponseEntity>.array, failure: @escaping RequestFailure)
    func deleteComment(commentID: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func getChildCommentList(commentID: String, offset: Int, limit: Int, success: @escaping SuccessHandler<CommentChildEntity>.object, failure: @escaping RequestFailure)
    
    func updateRecord(recordID: String, expiredDate: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    
    func getCommentResponse(recordId: String, offset: Int, success: @escaping SuccessHandler<CommentResponseEntity>.object, failure: @escaping RequestFailure)

    func getCommentParent(commentID: String, success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure)
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
    
    func hideRecord(recordID: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.hideRecord(recordID: recordID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func postRecord(param: PostRecordParam, success: @escaping SuccessHandler<RecordEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.postRecord(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getExpireDateRecord(success: @escaping SuccessHandler<ExpirePostEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.getExpirePostRecord()
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func deleteRecord(recordID: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.deleteRecord(recordID: recordID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getFavouriteRecord(status: String, offset: Int, limit: Int, success: @escaping SuccessHandler<RecordEntity>.array, failure: @escaping (APIError?) -> Void) {
        let endPoint = RecordEndPoint.getFavouriteRecord()
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }

    //--Comment
    func sendComment(param: SendCommentParam, success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.sendComment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func sendSubComment(param: SendCommentParam, success: @escaping SuccessHandler<SubCommentEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.sendComment(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func deleteComment(commentID: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.deleteComment(commentId: commentID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCommentResponse(recordId: String, offset: Int, success: @escaping SuccessHandler<CommentResponseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.getCommentResponse(recordId: recordId, offset: offset)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getChildCommentList(commentID: String, offset: Int, limit: Int, success: @escaping SuccessHandler<CommentChildEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.getChildCommentList(comentID: commentID, offset: offset, limit: limit)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateRecord(recordID: String, expiredDate: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.updateRecord(recordID: recordID, expiredDate: expiredDate)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCommentParent(commentID: String, success: @escaping SuccessHandler<CommentEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = RecordEndPoint.getCommentParent(commentID: commentID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
