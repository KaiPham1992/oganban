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
    case hideRecord(recordID: String)
    case postRecord(param: PostRecordParam)
    case getExpirePostRecord()
    case deleteRecord(recordID: String)
    case getFavouriteRecord()
    case sendComment(param: SendCommentParam)
    case getCommentList(recordId: String, offset: Int, limit: Int)
    case deleteComment(commentId: String)
    case updateRecord(recordID: String, expiredDate: String)
    case getChildCommentList(comentID: String, offset: Int, limit: Int)
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
        case .getExpirePostRecord:
            return "_api/record/expired_date_post_record"
        case .deleteRecord:
            return "_api/record/delete_record"
        case .getFavouriteRecord:
            return "_api/record/favourite"
            //--Comment
        case .getCommentList:
            return "_api/comment/get_comment_list"
        case .deleteComment:
            return "_api/comment/delete_comment"
        case .sendComment:
            return "_api/comment/send_comment"
        case.getChildCommentList:
            return "_api/comment/get_comment_child"
        case .updateRecord:
            return "_api/record/update_record"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecordSellerPost, .postRecord, .getExpirePostRecord, .getCommentList, .sendComment, .updateRecord, .getChildCommentList:
            return .post
        case .getRecordDetail, .getFavouriteRecord:
            return .get
        case .hideRecord, .deleteRecord, .deleteComment:
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
        case .getRecordDetail, .getExpirePostRecord, .getFavouriteRecord:
            return [:]
        case .hideRecord(let recordID):
            let param = ["record_id": recordID]
            return param
        case .postRecord(let param):
            return param.toJSON()
        case .deleteRecord(let recordID):
            let param = ["record_id": recordID]
            return param
            //--Comment
        case .getCommentList(let recordId, let offset, let limit):
            let param = ["record_id": recordId,
                         "offset": offset,
                         "limit": limit] as [String: Any]
            return param
        case .deleteComment(let commentId):
            let param = ["comment_id": commentId]
            return param
        case .sendComment(let param):
            return param.toJSON()
        case .updateRecord(let recordID, let expiredDate):
            let param = ["record_id": recordID,
                         "expired_date": expiredDate] as [String: Any]
            return param
        case .getChildCommentList(let comentID, let offset, let limit):
            let param = ["comment_id": comentID,
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
