//
//  SettingInteractor.swift
//  Oganban
//
//  Created DINH VAN TIEN on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SettingInteractor: SettingInteractorInputProtocol {

    weak var presenter: SettingInteractorOutputProtocol?
    
    func getPositionRange() {
        ProgressView.shared.show()
        Provider.shared.categoryAPIService.getPositionRange(success: { (result) in
            ProgressView.shared.hide()
            self.presenter?.didGetPositionRange(list: result)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
