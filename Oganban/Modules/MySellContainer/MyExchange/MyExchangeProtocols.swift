//
//  MyExchangeProtocols.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol MyExchangeWireframeProtocol: class {

}
//MARK: Presenter -
protocol MyExchangePresenterProtocol: class {

    var interactor: MyExchangeInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol MyExchangeInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol MyExchangeInteractorInputProtocol: class {

    var presenter: MyExchangeInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol MyExchangeViewProtocol: class {

    var presenter: MyExchangePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
