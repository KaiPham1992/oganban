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
    case sendComment(recordId: String, comment: String, commentId: String, isReComment: String)
    case getCommentList(recordId: String, offset: Int, limit: Int)
    case deleComent(commentId: String)
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
        case .deleComent:
            return "_api/comment/delete_comment"
        case .sendComment:
            return "_api/comment/send_comment"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecordSellerPost, .postRecord, .getExpirePostRecord, .getCommentList, .sendComment:
            return .post
        case .getRecordDetail, .getFavouriteRecord:
            return .get
        case .hideRecord, .deleteRecord, .deleComent:
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
        case .deleComent(let commentId):
            let param = ["comment_id": commentId]
            return param
        case .sendComment(let recordId, let comment, let commentId, let isReComment):
            let param = ["record_id": recordId,
                         "comment": comment,
                         "comment_id": commentId,
                         "is_re_cmt": isReComment] as [String: Any]
            return param
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
