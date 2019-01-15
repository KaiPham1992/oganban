//
//  FavouriteRouter.swift
//  Oganban
//
//  Created Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FavouriteRouter: FavouriteWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> FavouriteViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = FavouriteViewController(nibName: nil, bundle: nil)
        let interactor = FavouriteInteractor()
        let router = FavouriteRouter()
        let presenter = FavouritePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func showProductList(item: FavouriteEntity) {
        let vc = FavouriteProductListRouter.createModule()
        vc.favouriteUser = item
        self.viewController?.push(controller: vc, animated: true)
    }
    
    func gotoLogin() {
        let vc = LoginRouter.createModule()
        let nc = UINavigationController(rootViewController: vc)
        viewController?.present(controller: nc, animated: true)
    }
}
