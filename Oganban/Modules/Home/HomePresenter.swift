//
//  HomePresenter.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    func gotoPositionMaps(delegate: PositionViewControllerDelegate, address: String, dataSource: [PositionRangeEntity]) {
        router.gotoPositionMaps(delegate: delegate, address: address, dataSource: dataSource)
    }
    
    func getPositionRange() {
        interactor?.getPositionRange()
    }
    
    func filterRecord(param: RecordParam) {
        interactor?.filterRecord(param: param)
    }
    
    func getCategoryMerge() {
        interactor?.getCategoryMerge()
    }
    
    func getCategoryChild(id: String) {
        interactor?.getCategoryChild(id: id)
    }
    
    func getCategory() {
        interactor?.getCategory()
    }
    
   

    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    private let router: HomeWireframeProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomeInteractorOutputProtocol  {
    func didGetPositionRange(list: [PositionRangeEntity]) {
        view?.didGetPositionRange(list: list)
    }
    
    func didFilterRecord(list: [RecordEntity]) {
        view?.didFilterRecord(list: list)
    }
    
    func didGetCategoryMerge(list: [CategoryMergeEntity]) {
        view?.didGetCategoryMerge(list: list)
    }
    
    func getCategoryChildSuccess(list: [CategoryEntity]) {
        view?.getCategoryChildSuccess(list: list)
    }
    
    func getCategorySuccess(list: [CategoryEntity]) {
        view?.getCategorySuccess(list: list)
    }
    
}
