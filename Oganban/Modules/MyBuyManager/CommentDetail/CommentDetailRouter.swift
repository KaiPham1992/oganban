//
//  CommentDetailRouter.swift
//  Oganban
//
//  Created DINH VAN TIEN on 1/12/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CommentDetailRouter: CommentDetailWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(recordId: String?, commentId: String?) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = CommentDetailViewController(nibName: nil, bundle: nil)
        let interactor = CommentDetailInteractor()
        let router = CommentDetailRouter()
        let presenter = CommentDetailPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        view.recordId = recordId
        view.commentId = commentId
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
