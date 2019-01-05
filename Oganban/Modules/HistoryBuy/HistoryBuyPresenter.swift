//
//  HistoryBuyPresenter.swift
//  Oganban
//
//  Created Admin on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryBuyPresenter: HistoryBuyPresenterProtocol, HistoryBuyInteractorOutputProtocol {

    weak private var view: HistoryBuyViewProtocol?
    var interactor: HistoryBuyInteractorInputProtocol?
    private let router: HistoryBuyWireframeProtocol

    init(interface: HistoryBuyViewProtocol, interactor: HistoryBuyInteractorInputProtocol?, router: HistoryBuyWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
