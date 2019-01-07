//
//  MyBuyPresenter.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MyBuyPresenter: MyBuyPresenterProtocol {

    weak private var view: MyBuyViewProtocol?
    var interactor: MyBuyInteractorInputProtocol?
    private let router: MyBuyWireframeProtocol

    init(interface: MyBuyViewProtocol, interactor: MyBuyInteractorInputProtocol?, router: MyBuyWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getHistoryOrder(status: String, offset: Int, limit: Int) {
        interactor?.getHistoryOrder(status: status, offset: offset, limit: limit)
    }
    
    func gotoLogin() {
        router.gotoLogin()
    }
}

extension MyBuyPresenter: MyBuyInteractorOutputProtocol {
    func didGetHistoryOrder(data: BaseOrderEntity?) {
        view?.didGetHistoryOrder(data: data)
    }
}
