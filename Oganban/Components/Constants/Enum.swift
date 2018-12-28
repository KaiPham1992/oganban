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
    case version
    
    func index() -> Int {
        
        if self == .header {
            return 0
        }
        if self == .historyCoin {
            return 1
        }
        if self == .historyBuy {
            return 2
        }
        if self == .policy {
            return 3
        }
        if self == .tutorial {
            return 4
        }
        if self == .setting {
            return 5
        }
        
        if UserDefaultHelper.shared.loginUserInfo != nil {
            if self == .changePassword {
                return 6
            }
            if self == .logout {
                return 7
            }
            if self == .version {
                return 8
            }
        }
        return 6 // index for version if user don't login
    }
}
