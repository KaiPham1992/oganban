//
//  OrderDetailInteractor.swift
//  Oganban
//
//  Created Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class OrderDetailInteractor: OrderDetailInteractorInputProtocol {

    weak var presenter: OrderDetailInteractorOutputProtocol?
    
    func getDetail(id: String) {
        ProgressView.shared.show()
        Provider.shared.recordAPIService.getRecordDetail(id: id, success: { record in
            ProgressView.shared.hide()
            self.presenter?.didGetDetail(record: record)
        }) { _ in
            ProgressView.shared.hide()
        }
    }
    
    func hideRecord(recordID: String) {
        Provider.shared.recordAPIService.hideRecord(recordID: recordID, success: { (data) in
            self.presenter?.didHideRecord(data: data)
        }) { (_) in
            
        }
    }
}
