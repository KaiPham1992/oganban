//
//  Enum.swift
//  RedStar
//
//  Created by Ngoc Duong on 12/10/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
enum ProjectType: String {
    case complex = "Phức hợp"
    case resort = "BDS nghỉ dưỡng"
    case land = "Đất nền"
    case villa = "Biệt thự"
    case shopHouse = "Shophouse"
    case cityHouse = "Nhà phố"
    case apartment = "Căn hộ"
}

enum HomeMapTab: Int {
    case map = 0
    case listProject = 1
    case listHotProject = 2
    case listTVV = 3
}

enum MoreRowName: String, CaseIterable {
    case header
    case historyCoin
    case historyBuy
    case policy
    case tutorial
    case setting
    case changePassword
    case logout
    
    func index() -> Int {
        switch self {
        case .header:
            return 0
        case .historyCoin:
            return 1
        case .historyBuy:
            return 2
        case .policy:
            return 3
        case .tutorial:
            return 4
        case .setting:
            return 5
        case .changePassword:
            return 6
        case .logout:
            return 7
        }
    }
}
