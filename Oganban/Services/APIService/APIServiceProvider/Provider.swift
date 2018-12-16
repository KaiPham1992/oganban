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
    
    var projectAPIService: ProjectAPIServiceProtocol {
        return ProjectAPIService(network: networkManager)
    }
    
    var homeAPIService: HomeAPIServiceProtocol {
        return HomeAPIService(network: networkManager)
    }
    
    var consultationStaffAPIService: ConsultationStaffAPIServiceProtocol {
        return ConsultationStaffAPIService(network: networkManager)
    }
    
    var contractAPIService: ContractAPIServiceProtocol {
        return ContractAPIService(network: networkManager)
    }
    var appointmentAPIService: AppointmentAPIServiceProtocol {
        return AppointmentAPIService(network: networkManager)
    }
}
