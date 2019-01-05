//
//  NotificationDetailPresenter.swift
//  Oganban
//
//  Created Kai Pham on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NotificationDetailPresenter: NotificationDetailPresenterProtocol, NotificationDetailInteractorOutputProtocol {

    weak private var view: NotificationDetailViewProtocol?
    var interactor: NotificationDetailInteractorInputProtocol?
    private let router: NotificationDetailWireframeProtocol

    init(interface: NotificationDetailViewProtocol, interactor: NotificationDetailInteractorInputProtocol?, router: NotificationDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}