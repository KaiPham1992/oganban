//
//  MyBuyInteractor.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MyBuyInteractor: MyBuyInteractorInputProtocol {

    weak var presenter: MyBuyInteractorOutputProtocol?
    
    func getHistoryOrder(status: String, offset: Int, limit: Int) {
        ProgressView.shared.show()
        Provider.shared.orderAPIService.getHistoryOrder(status: status, limit: limit, offset: offset, success: { (data) in
            ProgressView.shared.hide()
            self.presenter?.didGetHistoryOrder(data: data)
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
}