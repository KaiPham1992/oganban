//
//  HistoryBuyRouter.swift
//  Oganban
//
//  Created Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryBuyRouter: HistoryBuyWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryBuyViewController(nibName: nil, bundle: nil)
        let interactor = HistoryBuyInteractor()
        let router = HistoryBuyRouter()
        let presenter = HistoryBuyPresenter(interface: view, interactor: interactor, router: router)

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
