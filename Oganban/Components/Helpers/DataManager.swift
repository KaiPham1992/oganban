//
//  DataManager.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit
import GoogleMaps

class DataManager {
    // MARK: - Properties
    
    // MARK: - Accessors
    
    static let shared = DataManager()
    
    var tempToken: String = ""
    var maxDate: Date = Date()
    
    func getNotificationCount(done: @escaping (_ count: Int)-> ()) {
        ProgressView.shared.show()
        Provider.shared.notificationAPIService.getNotification(offset: 0, success: { notifications in
            ProgressView.shared.hide()
            guard let noti = notifications else { return}
            done(noti.notifications.count)
        }) {  error in
            ProgressView.shared.hide()
            done(0)
        }
    }
}
