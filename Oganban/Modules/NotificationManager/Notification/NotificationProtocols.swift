//
//  NotificationProtocols.swift
//  RedStar
//
//  Created Ngoc Duong on 12/13/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol NotificationWireframeProtocol: class {
    func gotoLogin()
}
//MARK: Presenter -
protocol NotificationPresenterProtocol: class {

    var interactor: NotificationInteractorInputProtocol? { get set }
    
    func getNotification(offset: Int)
    func readNotification(id: String)
    func gotoLogin()
}

//MARK: Interactor -
protocol NotificationInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetNotification(notifications: ParentNotificationEntity?)
    func didGetError(error: APIError?)
}

protocol NotificationInteractorInputProtocol: class {

    var presenter: NotificationInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getNotification(offset: Int)
    func readNotification(id: String)
}

//MARK: View -
protocol NotificationViewProtocol: class {

    var presenter: NotificationPresenterProtocol?  { get set }
    func didGetNotification(notifications: ParentNotificationEntity?)
    func didGetError(error: APIError?)

    /* Presenter -> ViewController */
}
