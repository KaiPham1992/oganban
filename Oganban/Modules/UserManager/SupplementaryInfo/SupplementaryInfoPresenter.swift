//
//  SupplementaryInfoPresenter.swift
//  Oganban
//
//  Created Kent on 12/20/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SupplementaryInfoPresenter: SupplementaryInfoPresenterProtocol  {

    weak private var view: SupplementaryInfoViewProtocol?
    var interactor: SupplementaryInfoInteractorInputProtocol?
    private let router: SupplementaryInfoWireframeProtocol

    init(interface: SupplementaryInfoViewProtocol, interactor: SupplementaryInfoInteractorInputProtocol?, router: SupplementaryInfoWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func loginSocial(socialParam: LoginSocialParam) {
        interactor?.loginSocial(socialParam: socialParam)
    }

}

extension SupplementaryInfoPresenter: SupplementaryInfoInteractorOutputProtocol {
    func didLogin(user: UserEntity?) {
        view?.didLogin(user: user)
    }
    
    func didLogin(error: APIError?) {
        view?.didLogin(error: error)
    }
}