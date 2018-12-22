//
//  SupplementaryInfoPresenter.swift
//  Oganban
//
//  Created Admin on 12/20/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SupplementaryInfoPresenter: SupplementaryInfoPresenterProtocol, SupplementaryInfoInteractorOutputProtocol {

    weak private var view: SupplementaryInfoViewProtocol?
    var interactor: SupplementaryInfoInteractorInputProtocol?
    private let router: SupplementaryInfoWireframeProtocol

    init(interface: SupplementaryInfoViewProtocol, interactor: SupplementaryInfoInteractorInputProtocol?, router: SupplementaryInfoWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
