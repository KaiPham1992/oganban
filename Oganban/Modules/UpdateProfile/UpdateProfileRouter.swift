//
//  UpdateProfileRouter.swift
//  Oganban
//
//  Created Admin on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class UpdateProfileRouter: UpdateProfileWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = UpdateProfileViewController(nibName: nil, bundle: nil)
        let interactor = UpdateProfileInteractor()
        let router = UpdateProfileRouter()
        let presenter = UpdateProfilePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
