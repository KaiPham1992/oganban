//
//  CategoryEndPoint.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Alamofire

enum CategoryEndPoint {
    case getCategory()
    case getCategoryChild(categoryId: String)
    case getCategoryMerge()
    case filterRecord(param: RecordParam)
    case getPositionRange()
    case getCountRecordPosition(long: CGFloat, lat: CGFloat, radius: Int)
}

extension CategoryEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getCategory:
            return "_api/category/get_category"
        case .getCategoryChild:
            return "_api/category/get_category_child"
        case .getCategoryMerge:
            return "_api/category/get_category_merge"
        case .filterRecord:
            return "_api/record/get_all_records_by_category"
        case .getPositionRange:
            return "_api/common/position_range"
        case .getCountRecordPosition(let long, let lat, let radius):
            return "_api/record/count_record_position"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getCategory, .getCategoryChild, .getCategoryMerge, .filterRecord, .getPositionRange, .getCountRecordPosition:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getCategory, .getCategoryMerge:
            return [:]
        case .getCategoryChild(let categoryId):
            return ["category_id": categoryId]
        case .filterRecord(let param):
            return param.toJSON()
        case .getPositionRange:
            return [:]
        case .getCountRecordPosition(let long, let lat, let radius):
            return ["longitude": long,
                    "latitude": lat,
                    "nearby_radius": radius]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
    
    
}
