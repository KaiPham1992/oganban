//
//  MyBuyProtocols.swift
//  Oganban
//
//  Created Coby on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol MyBuyWireframeProtocol: class {

}
//MARK: Presenter -
protocol MyBuyPresenterProtocol: class {

    var interactor: MyBuyInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol MyBuyInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol MyBuyInteractorInputProtocol: class {

    var presenter: MyBuyInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol MyBuyViewProtocol: class {

    var presenter: MyBuyPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}