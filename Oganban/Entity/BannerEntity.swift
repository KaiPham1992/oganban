//
//  BannerEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

class BannerEntity {
    var url: String?
    
    convenience init(url: String?) {
        self.init()
        self.url = url
    }
}
