//
//  MoreRouter.swift
//  Oganban
//
//  Created Kent on 12/20/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MoreRouter: MoreWireframeProtocol {
    
    weak var viewController: MoreViewController?
    
    static func createModule() -> MoreViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MoreViewController.initFromNib()
        let interactor = MoreInteractor()
        let router = MoreRouter()
        let presenter = MorePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToPage (name: MoreEntityType){
        switch name {
        case MoreEntityType.header:
            tapHeader()
            print("Tap header")
            break
        case MoreEntityType.historyCoin:
            tapHistoryCoin()
            print("Chọn Lịch sử ƠCoin")
            break
        case MoreEntityType.historyBuy:
            tapHistoryBuy()
            print("Chọn Lịch sử mua tin")
            break
        case MoreEntityType.policy:
            tapPolicy()
            print("Chọn Điều khoản sử dụng")
            break
        case MoreEntityType.tutorial:
            tapTutorial()
            break
        case MoreEntityType.setting:
            tapSetting()
            print("Chọn Cài đặt")
            break
        case MoreEntityType.changePassword:
            tapChangePassword()
            print("Chọn Đổi mật khẩu")
            break
        case MoreEntityType.logout:
            print("Chọn Đăng xuất")
            
            break
        default:
            break
        }
        
    }
    
    private func tapTutorial(){
        let vc =  WebViewController.initFromNib()
        guard let url = URL(string: Link.tutorial) else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    private func tapHeader(){
        if UserDefaultHelper.shared.loginUserInfo == nil {
            let vc = LoginRouter.createModule()
            let nc = UINavigationController(rootViewController: vc)
            viewController?.present(controller: nc, animated: true)
        } else {
            let vc = UpdateProfileRouter.createModule()
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func tapHistoryCoin(){
        let vc = HistoryCoinRouter.createModule()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func tapHistoryBuy(){
        let vc = HistoryBuyRouter.createModule()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    

    private func tapPolicy() {
        let vc =  WebViewController.initFromNib()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func tapChangePassword() {
        let vc = ChangePasswordRouter.createModule()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func tapSetting() {
        let vc = SettingRouter.createModule()
        viewController?.push(controller: vc)
    }
}
