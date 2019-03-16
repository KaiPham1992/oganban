//
//  UpdateProfilePresenter.swift
//  Oganban
//
//  Created Kent on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class UpdateProfilePresenter: UpdateProfilePresenterProtocol {

    weak private var view: UpdateProfileViewProtocol?
    var interactor: UpdateProfileInteractorInputProtocol?
    private let router: UpdateProfileWireframeProtocol

    init(interface: UpdateProfileViewProtocol, interactor: UpdateProfileInteractorInputProtocol?, router: UpdateProfileWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func updateProfile(userInfo: UpdateProfileParam) {
        interactor?.updateProfile(userInfo: userInfo)
    }
    
    func updateAvatar(image: UIImage) {
        interactor?.updateAvatar(image: image)
    }

    func getProfileUser() {
        interactor?.getProfileUser()
    }
}
extension UpdateProfilePresenter: UpdateProfileInteractorOutputProtocol{
    func didSuccessUpdateProfile(user: UserEntity?) {
         view?.didSuccessUpdateProfile(user: user)
    }
    
    func didErrorUpdateProfile(error: APIError?) {
         view?.didErrorUpdateProfile(error: error)
    }
    
    func didGetProfileUser(user: UserEntity?) {
        view?.didGetProfileUser(user: user)
    }
}
