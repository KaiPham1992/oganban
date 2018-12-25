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

class OrderDetailPresenter: OrderDetailPresenterProtocol, OrderDetailInteractorOutputProtocol {

    weak private var view: OrderDetailViewProtocol?
    var interactor: OrderDetailInteractorInputProtocol?
    private let router: OrderDetailWireframeProtocol

    init(interface: OrderDetailViewProtocol, interactor: OrderDetailInteractorInputProtocol?, router: OrderDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}