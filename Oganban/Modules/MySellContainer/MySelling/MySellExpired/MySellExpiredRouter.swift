//
//  MySellExpiredRouter.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MySellExpiredRouter: MySellExpiredWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MySellExpiredViewController(nibName: nil, bundle: nil)
        let interactor = MySellExpiredInteractor()
        let router = MySellExpiredRouter()
        let presenter = MySellExpiredPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
