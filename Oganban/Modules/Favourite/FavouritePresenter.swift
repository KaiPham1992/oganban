//
//  FavouritePresenter.swift
//  Oganban
//
//  Created Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FavouritePresenter: FavouritePresenterProtocol {

    weak private var view: FavouriteViewProtocol?
    var interactor: FavouriteInteractorInputProtocol?
    private let router: FavouriteWireframeProtocol

    init(interface: FavouriteViewProtocol, interactor: FavouriteInteractorInputProtocol?, router: FavouriteWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    func getFavourite(offset: Int) {
        interactor?.getFavourite(offset: offset)
    }
    
    func showProductList(item: FavouriteEntity) {
        router.showProductList(item: item)
    }
    
    func addRemoveFavourite(isFavorite: Int, accountId: Int) {
        interactor?.addRemoveFavourite(isFavorite: isFavorite, accountId: accountId)
    }
}

extension FavouritePresenter: FavouriteInteractorOutputProtocol{
    func addRemoveSucessFavourite(baseResponse: BaseResponse?) {
        view?.addRemoveSucessFavourite(baseResponse: baseResponse)
    }
    
    func getSucessFavourite(favourite: [FavouriteEntity]) {
        view?.getSucessFavourite(favourite: favourite)
    }
    
    func getErrorFavourite(error: APIError?) {
        view?.getErrorFavourite(error: error)
    }
}
