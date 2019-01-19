//
//  NotificationRouter.swift
//  RedStar
//
//  Created Ngoc Duong on 12/13/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NotificationRouter: NotificationWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = NotificationViewController(nibName: nil, bundle: nil)
        let interactor = NotificationInteractor()
        let router = NotificationRouter()
        let presenter = NotificationPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func gotoLogin() {
        let vc = LoginRouter.createModule()
        let nc = UINavigationController(rootViewController: vc)
        viewController?.present(controller: nc, animated: true)
    }
}
