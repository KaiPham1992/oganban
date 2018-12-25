//
//  UpdateProfileInteractor.swift
//  Oganban
//
//  Created Kent on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class UpdateProfileInteractor: UpdateProfileInteractorInputProtocol {

    weak var presenter: UpdateProfileInteractorOutputProtocol?
    
    func updateProfile(userInfo: UserEntity) {
        ProgressView.shared.show()
        Provider.shared.userAPIService.updateProfile(param: userInfo, success: { (user) in
            ProgressView.shared.hide()
            self.presenter?.didSuccessUpdateProfile(user: userInfo)
        }) { (error) in
            ProgressView.shared.hide()
            self.presenter?.didErrorUpdateProfile(error: error)
        }
    }
}
