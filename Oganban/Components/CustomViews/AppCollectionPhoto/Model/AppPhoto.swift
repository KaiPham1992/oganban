//
//  AppPhoto.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

enum AppPhotoStatus {
    case uploaded
    case new
    case error
}

class AppPhoto: NSObject {
    var status: AppPhotoStatus
    var url: String?
    var image: UIImage?
    
    init(status: AppPhotoStatus, image: UIImage?, url: String?) {
        self.status = status
        self.image = image
        self.url = url
        super.init()
    }
}
