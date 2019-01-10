//
//  OrderDetailInteractor.swift
//  Oganban
//
//  Created Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class OrderBuyDetailInteractor: OrderBuyDetailInteractorInputProtocol {

    weak var presenter: OrderBuyDetailInteractorOutputProtocol?
    
    func getDetail(id: String) {
        ProgressView.shared.show()
        Provider.shared.recordAPIService.getRecordDetail(id: id, success: { record in
            ProgressView.shared.hide()
            self.presenter?.didGetDetail(record: record)
        }) { _ in
            ProgressView.shared.hide()
        }
    }
    
    func bookingOrder(recordID: String, price: Double, quantity: Int, paymentType: String, isService: Bool) {
        ProgressView.shared.show()
        Provider.shared.orderAPIService.bookingOrder(recordID: recordID, price: price, quantity: quantity, paymentType: paymentType, isService: isService, success: { (order) in
            ProgressView.shared.hide()
            self.presenter?.didBooking(order: order)
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
    
    func AddFavorite(isFavorite: Int, accountID: Int) {
//        Provider.shared.userAPIService.addFavoriteStaff(isFavorite: isFavorite, accountID: accountID, success: { (data) in
//            self.presenter?.didAddFavorite(data: data)
//        }) { (_) in
//
//        }
        Provider.shared.userAPIService.removeFavourite(isFavorite: isFavorite, accountId: accountID, success: { (data) in
            self.presenter?.didAddFavorite(data: data)
        }) { (_) in
            
        }
    }
}
