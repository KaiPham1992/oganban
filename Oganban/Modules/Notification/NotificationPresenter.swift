//
//  NotificationPresenter.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NotificationPresenter: NotificationPresenterProtocol, NotificationInteractorOutputProtocol {

    weak private var view: NotificationViewProtocol?
    var interactor: NotificationInteractorInputProtocol?
    private let router: NotificationWireframeProtocol

    init(interface: NotificationViewProtocol, interactor: NotificationInteractorInputProtocol?, router: NotificationWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
