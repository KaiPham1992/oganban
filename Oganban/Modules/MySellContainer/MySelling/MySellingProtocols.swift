//
//  MySellingProtocols.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol MySellingWireframeProtocol: class {

}
//MARK: Presenter -
protocol MySellingPresenterProtocol: class {

    var interactor: MySellingInteractorInputProtocol? { get set }
    func getRecordSellerPost(status: String, offset: Int, limit: Int)
    
    //--
}

//MARK: Interactor -
protocol MySellingInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetRecordSellerPost(listRecord: [RecordEntity])
    func didGetRecordSellerPost(error: APIError?)
}

protocol MySellingInteractorInputProtocol: class {

    var presenter: MySellingInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getRecordSellerPost(status: String, offset: Int, limit: Int)
}

//MARK: View -
protocol MySellingViewProtocol: class {

    var presenter: MySellingPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetRecordSellerPost(listRecord: [RecordEntity])
    func didGetRecordSellerPost(error: APIError?)
}
