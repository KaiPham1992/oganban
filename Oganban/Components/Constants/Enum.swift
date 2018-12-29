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

