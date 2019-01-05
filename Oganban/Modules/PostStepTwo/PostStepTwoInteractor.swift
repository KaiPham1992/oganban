//
//  PostStepTwoInteractor.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PostStepTwoInteractor: PostStepTwoInteractorInputProtocol {
    
    weak var presenter: PostStepTwoInteractorOutputProtocol?
    
    func postRecord(param: PostRecordParam) {
        ProgressView.shared.show()
        Provider.shared.recordAPIService.postRecord(param: param, success: { _record in
            ProgressView.shared.hide()
            self.presenter?.didPostRecord(record: _record)
        }) { error in
            ProgressView.shared.hide()
            self.presenter?.didError(error: error)
        }
    }
}