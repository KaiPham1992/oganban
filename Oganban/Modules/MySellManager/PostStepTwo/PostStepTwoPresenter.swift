//
//  PostStepTwoPresenter.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PostStepTwoPresenter: PostStepTwoPresenterProtocol {

    weak private var view: PostStepTwoViewProtocol?
    var interactor: PostStepTwoInteractorInputProtocol?
    private let router: PostStepTwoWireframeProtocol

    init(interface: PostStepTwoViewProtocol, interactor: PostStepTwoInteractorInputProtocol?, router: PostStepTwoWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func postRecord(param: PostRecordParam) {
        interactor?.postRecord(param: param)
    }
}

extension PostStepTwoPresenter: PostStepTwoInteractorOutputProtocol {
    func didError(error: APIError?) {
        view?.didError(error: error)
    }
    
    func didPostRecord(record: RecordEntity?) {
        view?.didPostRecord(record: record)
    }
    
    
}