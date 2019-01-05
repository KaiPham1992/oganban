//
//  PostStepOnePresenter.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PostStepOnePresenter: PostStepOnePresenterProtocol {
    func getCategoryMerge() {
        interactor?.getCategoryMerge()
    }
    

    weak private var view: PostStepOneViewProtocol?
    var interactor: PostStepOneInteractorInputProtocol?
    private let router: PostStepOneWireframeProtocol

    init(interface: PostStepOneViewProtocol, interactor: PostStepOneInteractorInputProtocol?, router: PostStepOneWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}

extension PostStepOnePresenter: PostStepOneInteractorOutputProtocol {
    func didGetCategoryMerge(list: [CategoryMergeEntity]) {
        view?.didGetCategoryMerge(list: list)
    }
}