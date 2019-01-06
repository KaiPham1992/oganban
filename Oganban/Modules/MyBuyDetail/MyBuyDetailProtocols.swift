//
//  MyBuyDetailProtocols.swift
//  Oganban
//
//  Created Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol MyBuyDetailWireframeProtocol: class {

}
//MARK: Presenter -
protocol MyBuyDetailPresenterProtocol: class {

    var interactor: MyBuyDetailInteractorInputProtocol? { get set }
    func getDetailOrder(id: String)
}

//MARK: Interactor -
protocol MyBuyDetailInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetOrder(order: OrderEntity?)
}

protocol MyBuyDetailInteractorInputProtocol: class {

    var presenter: MyBuyDetailInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getDetailOrder(id: String)
}

//MARK: View -
protocol MyBuyDetailViewProtocol: class {

    var presenter: MyBuyDetailPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetOrder(order: OrderEntity?)
}
