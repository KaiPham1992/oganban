//
//  MyBuyRouter.swift
//  Oganban
//
//  Created Coby on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MyBuyRouter: MyBuyWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MyBuyViewController(nibName: nil, bundle: nil)
        let interactor = MyBuyInteractor()
        let router = MyBuyRouter()
        let presenter = MyBuyPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
