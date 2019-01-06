//
//  SettingPresenter.swift
//  Oganban
//
//  Created DINH VAN TIEN on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SettingPresenter: SettingPresenterProtocol {
    func getPositionRange() {
        interactor?.getPositionRange()
    }
    

    weak private var view: SettingViewProtocol?
    var interactor: SettingInteractorInputProtocol?
    private let router: SettingWireframeProtocol

    init(interface: SettingViewProtocol, interactor: SettingInteractorInputProtocol?, router: SettingWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension SettingPresenter: SettingInteractorOutputProtocol {
    func didGetPositionRange(list: [PositionRangeEntity]) {
        view?.didGetPositionRange(list: list)
    }
}