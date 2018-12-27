//
//  ForgotPasswordProtocols.swift
//  Oganban
//
//  Created Coby on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ForgotPasswordWireframeProtocol: class {

}
//MARK: Presenter -
protocol ForgotPasswordPresenterProtocol: class {

    var interactor: ForgotPasswordInteractorInputProtocol? { get set }
    func forgotPassword(email: String)
}

//MARK: Interactor -
protocol ForgotPasswordInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didForgotPassword(data: BaseResponse?)
    func didForgotPassword(error: APIError?)
}

protocol ForgotPasswordInteractorInputProtocol: class {

    var presenter: ForgotPasswordInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func forgotPassword(email: String)
}

//MARK: View -
protocol ForgotPasswordViewProtocol: class {

    var presenter: ForgotPasswordPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didForgotPassword(data: BaseResponse?)
    func didForgotPassword(error: APIError?)
}