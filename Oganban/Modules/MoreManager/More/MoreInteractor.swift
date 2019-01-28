//
//  MoreInteractor.swift
//  Oganban
//
//  Created Kent on 12/20/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MoreInteractor: MoreInteractorInputProtocol {

    weak var presenter: MoreInteractorOutputProtocol?
    
    func logout() {
        ProgressView.shared.show()
        
        Provider.shared.userAPIService.logout(success: { (_) in
            ProgressView.shared.hide()
            UserUtils.clearLogin()
            self.presenter?.logoutSuccess()
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getProfileUser() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.getProfileUser(success: { (user) in
            self.presenter?.didGetProfileUser(user: user)
            ProgressView.shared.hide()
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
}
