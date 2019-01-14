//
//  SignUpRouter.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpRouter: SignUpWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> SignUpViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = SignUpViewController.initFromNib()
        let interactor = SignUpInteractor()
        let router = SignUpRouter()
        let presenter = SignUpPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func gotoTermOfPolicy() {
        let vc =  WebViewController.initFromNib()
        vc.isSignUp = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
