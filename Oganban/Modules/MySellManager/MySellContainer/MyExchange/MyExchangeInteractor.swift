//
//  MyExchangeInteractor.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MyExchangeInteractor: MyExchangeInteractorInputProtocol {

    weak var presenter: MyExchangeInteractorOutputProtocol?
    
    func getTransactionSeller(status: String, limit: Int, offset: Int) {
        ProgressView.shared.show()
        Provider.shared.orderAPIService.getTransactionSeller(status: status, limit: limit, offset: offset, success: { (data) in
            ProgressView.shared.hide()
            self.presenter?.didGetTransactionSeller(data: data)
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
}
