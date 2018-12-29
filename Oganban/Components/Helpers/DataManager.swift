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
    
    // Initialization
    private init() {
        
    }
    
    // MARK: - Accessors
    
    class func shared() -> DataManager {
        return sharedDataManager
    }
    
}
