//
//  ForgotPasswordPresenter.swift
//  Oganban
//
//  Created Coby on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {

    weak private var view: ForgotPasswordViewProtocol?
    var interactor: ForgotPasswordInteractorInputProtocol?
    private let router: ForgotPasswordWireframeProtocol

    init(interface: ForgotPasswordViewProtocol, interactor: ForgotPasswordInteractorInputProtocol?, router: ForgotPasswordWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func forgotPassword(email: String) {
        interactor?.forgotPassword(email: email)
    }
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutputProtocol {
    func didForgotPassword(data: BaseResponse?) {
        view?.didForgotPassword(data: data)
    }
    
    func didForgotPassword(error: APIError?) {
        view?.didForgotPassword(error: error)
    }
}