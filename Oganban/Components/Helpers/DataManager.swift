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
    
    private static var sharedDataManager: DataManager = {
        let dataManager = DataManager()
        
        // Configuration
        // ...
        
        return dataManager
    }()
    
//    var loginedUser: UserEntity?
//    var listProvince = [ProvinceEntity]()
//    var listProjectType = [ProjectTypeEntity]()
    var isShowCompare = false
    var isSelectedFromFind = false
    var centerMap = CLLocationCoordinate2D()
    
    var isShowBannerHome = true
    
//    var projectSelected: ProjectEntity? // use to view detail
    
    var homeMapTab = HomeMapTab.map
//    var listLevel = [LevelEntity]()
    
    // Initialization
    private init() {
        
    }
    
    // MARK: - Accessors
    
    class func shared() -> DataManager {
        return sharedDataManager
    }
    
}
