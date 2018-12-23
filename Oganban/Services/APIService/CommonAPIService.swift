//
//  CommonAPIService.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

protocol CommonAPIServiceProtocol {
    func uploadImage(image: UIImage, success: @escaping SuccessHandler<PhotoEntity>.object, failure: @escaping RequestFailure)
    
}

class CommonAPIService: CommonAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func uploadImage(image: UIImage, success: @escaping SuccessHandler<PhotoEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = CommonEndPoint.uploadImages(image: image)
        network.uploadImages(image: image, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
