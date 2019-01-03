//
//  Provider.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation

class Provider {
    static let shared = Provider()
    
    private let request: NetworkRequestProtocol = NetworkRequest()
    
    private var networkManager: APINetworkProtocol {
        return APINetwork(request: request)
    }
    
    var userAPIService: UserAPIServiceProtocol {
        return UserAPIService(network: networkManager)
    }
    
    var commonAPIService: CommonAPIServiceProtocol {
        return CommonAPIService(network: networkManager)
    }
    
    var categoryAPIService: CategoryAPIServiceProtocol {
        return CategoryAPIService(network: networkManager)
    }
    
    var notificationAPIService: NotificationAPIServiceProtocol {
        return NotificationAPIService(network: networkManager)
    }
    
    var recordAPIService: RecordAPIServiceProtocol {
        return RecordAPIService(network: networkManager)
    }
    
    var orderAPIService: OrderAPIServiceProtocol {
        return OrderAPIService(network: networkManager)
    }
}
