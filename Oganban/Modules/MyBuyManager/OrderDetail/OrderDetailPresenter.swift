//
//  OrderDetailPresenter.swift
//  Oganban
//
//  Created Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class OrderDetailPresenter: OrderDetailPresenterProtocol {

    weak private var view: OrderDetailViewProtocol?
    var interactor: OrderDetailInteractorInputProtocol?
    private let router: OrderDetailWireframeProtocol

    init(interface: OrderDetailViewProtocol, interactor: OrderDetailInteractorInputProtocol?, router: OrderDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    

    func getDetail(id: String) {
        interactor?.getDetail(id: id)
    }
    
    func hideRecord(recordID: Int) {
        interactor?.hideRecord(recordID: recordID)
    }
}

extension OrderDetailPresenter: OrderDetailInteractorOutputProtocol {
    func didGetDetail(record: RecordEntity?) {
        view?.didGetDetail(record: record)
    }
    
    func didHideRecord(data: BaseResponse?) {
        view?.didHideRecord(data: data)
    }
}