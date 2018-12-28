//
//  SupplementaryInfoProtocols.swift
//  Oganban
//
//  Created Kent on 12/20/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol SupplementaryInfoWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol SupplementaryInfoPresenterProtocol: class {
    
    var interactor: SupplementaryInfoInteractorInputProtocol? { get set }
    func updateLoginSocial(socialParam: UpdateProfileSocial)
}

//MARK: Interactor -
protocol SupplementaryInfoInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func didLogin(user: UserEntity?)
    func didLogin(error: APIError?)
}

protocol SupplementaryInfoInteractorInputProtocol: class {
    
    var presenter: SupplementaryInfoInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
    func updateLoginSocial(socialParam: UpdateProfileSocial)
}

//MARK: View -
protocol SupplementaryInfoViewProtocol: class {
    
    var presenter: SupplementaryInfoPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func didLogin(user: UserEntity?)
    func didLogin(error: APIError?)
}
