//
//  PostStepTwoRouter.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PostStepTwoRouter: PostStepTwoWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(param: PostRecordParam, isUpdate: Bool = false) -> PostStepTwoViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = PostStepTwoViewController.initFromNib()
        let interactor = PostStepTwoInteractor()
        let router = PostStepTwoRouter()
        let presenter = PostStepTwoPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        view.param = param
        view.isCopyUpdate = isUpdate
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(param: PostRecordParam, isUpdate: Bool = false, record: RecordEntity?) -> PostStepTwoViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = PostStepTwoViewController.initFromNib()
        let interactor = PostStepTwoInteractor()
        let router = PostStepTwoRouter()
        let presenter = PostStepTwoPresenter(interface: view, interactor: interactor, router: router)
        
        view.record = record
        view.presenter = presenter
        view.param = param
        view.isCopyUpdate = isUpdate
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
}
