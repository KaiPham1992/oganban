//
//  MybuyPresenter.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MybuyPresenter: MybuyPresenterProtocol, MybuyInteractorOutputProtocol {

    weak private var view: MybuyViewProtocol?
    var interactor: MybuyInteractorInputProtocol?
    private let router: MybuyWireframeProtocol

    init(interface: MybuyViewProtocol, interactor: MybuyInteractorInputProtocol?, router: MybuyWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}