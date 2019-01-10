//
//  OrderDetailPresenter.swift
//  Oganban
//
//  Created Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class OrderBuyDetailPresenter: OrderBuyDetailPresenterProtocol {

    weak private var view: OrderBuyDetailViewProtocol?
    var interactor: OrderBuyDetailInteractorInputProtocol?
    private let router: OrderBuyDetailWireframeProtocol

    init(interface: OrderBuyDetailViewProtocol, interactor: OrderBuyDetailInteractorInputProtocol?, router: OrderBuyDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    

    func getDetail(id: String) {
        interactor?.getDetail(id: id)
    }
    
    func bookingOrder(recordID: String, price: Double, quantity: Int, paymentType: String, isService: Bool) {
        interactor?.bookingOrder(recordID: recordID, price: price, quantity: quantity, paymentType: paymentType, isService: isService)
    }
    
    func AddFavorite(isFavorite: Int, accountID: Int) {
        interactor?.AddFavorite(isFavorite: isFavorite, accountID: accountID)
    }
    
    //--
    func gotoLogin() {
        router.gotoLogin()
    }
}

extension OrderBuyDetailPresenter: OrderBuyDetailInteractorOutputProtocol {
    func didGetDetail(record: RecordEntity?) {
        view?.didGetDetail(record: record)
    }
    
    func didBooking(order: OrderEntity?) {
        view?.didBooking(order: order)
    }
    
    func didAddFavorite(data: BaseResponse?) {
        view?.didAddFavorite(data: data)
    }
}
