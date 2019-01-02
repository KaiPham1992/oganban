//
//  HomeProtocols.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HomeWireframeProtocol: class {
    func gotoPositionMaps(delegate: PositionViewControllerDelegate, address: String, dataSource: [PositionRangeEntity], distance: PositionRangeEntity)

}
//MARK: Presenter -
protocol HomePresenterProtocol: class {

    var interactor: HomeInteractorInputProtocol? { get set }
    func getCategory()
    func getCategoryChild(id: String)
    func getCategoryMerge()
    func filterRecord(param: RecordParam)
    func getPositionRange()
    func gotoPositionMaps(delegate: PositionViewControllerDelegate, address: String, dataSource: [PositionRangeEntity], distance: PositionRangeEntity)
}

//MARK: Interactor -
protocol HomeInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func getCategorySuccess(list: [CategoryEntity])
    func getCategoryChildSuccess(list: [CategoryEntity])
    func didGetCategoryMerge(list: [CategoryMergeEntity])
    func didFilterRecord(list: [RecordEntity])
    func didGetPositionRange(list: [PositionRangeEntity])
}

protocol HomeInteractorInputProtocol: class {

    var presenter: HomeInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getCategory()
    func getCategoryChild(id: String)
    func getCategoryMerge()
    func filterRecord(param: RecordParam)
    func getPositionRange()
}

//MARK: View -
protocol HomeViewProtocol: class {

    var presenter: HomePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func getCategorySuccess(list: [CategoryEntity])
    func getCategoryChildSuccess(list: [CategoryEntity])
    func didGetCategoryMerge(list: [CategoryMergeEntity])
    func didFilterRecord(list: [RecordEntity])
    func didGetPositionRange(list: [PositionRangeEntity])
}
