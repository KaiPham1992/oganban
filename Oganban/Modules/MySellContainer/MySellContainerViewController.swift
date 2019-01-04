//
//  MySellContainerViewController.swift
//  Oganban
//
//  Created Kai Pham on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MySellContainerViewController: BaseViewController, MySellContainerViewProtocol {

	var presenter: MySellContainerPresenterProtocol?
    @IBOutlet weak var vPageView: AppPageView!
    
    var listControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleNavigation(title: NavigationTitle.mySell)
        self.tabBarController?.tabBar.isHidden = false
        
        let sellingVC = MySellingRouter.createModule(delegate: self)
        
//        vc1.view.backgroundColor = .red
        sellingVC.parrentNavigation = self.navigationController
        
        let exchangeVC = MyExchangeRouter.createModule(delegate: self)
//        vc2.view.backgroundColor = .green
        exchangeVC.parrentNavigation = self.navigationController
        
        let listItem = [
            KCategory(title: "ĐANG BÁN", isSelected: true),
            KCategory(title: "GIAO DỊCH", isSelected: false)
        ]
        
        self.listControllers = [sellingVC, exchangeVC]
        vPageView.setUpMenuAndController(controllers: listControllers, menuColorBackground: AppColor.white, menuFont: AppFont.fontRegular11, menuColorNormal: AppColor.gray_158_158_158, menuColorSelected: AppColor.green, menuColorHorizontal: AppColor.red_110_0_0, heightHorizontal: 2, listItem: listItem, isFull: true, isHaveLineTop: false)
    }

}

extension MySellContainerViewController: MySellingViewControllerDelegate, MyExchangeViewControllerDelegate {
    func gotoLogin() {
        presenter?.gotoLogin()
    }
    
    func gotoMySellExpired() {
        presenter?.gotoMySellExpired()
    }
}
