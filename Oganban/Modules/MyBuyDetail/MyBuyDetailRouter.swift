//
//  MyBuyDetailRouter.swift
//  Oganban
//
//  Created Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MyBuyDetailRouter: MyBuyDetailWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(orderId: String, isSaler: Bool ) -> MyBuyDetailViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MyBuyDetailViewController(nibName: nil, bundle: nil)
        let interactor = MyBuyDetailInteractor()
        let router = MyBuyDetailRouter()
        let presenter = MyBuyDetailPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        view.orderId = orderId
        view.isSaler = isSaler
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
