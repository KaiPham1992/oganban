//
//  MoreViewController.swift
//  free
//
//  Created by Kent on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {
    
    var presenter: MorePresenterProtocol?
    
    @IBOutlet weak var tvMore: UITableView!
    
    var rowList: [MoreEntityType] = [MoreEntityType]()
    
    var user: UserEntity? {
        didSet {
            tvMore.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleNavigation(title: NavigationTitle.more)
        self.registerTableView()
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(btnReloadPage), name: AppConstant.notiReloadMoreView, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showTabbar()
        DataManager.shared.getNotificationCount { (count) in
            if let tabItems = self.tabBarController?.tabBar.items {
                let tabItem = tabItems[3]
                if count == 0 {
                    tabItem.badgeValue = nil
                } else if count >= 100 {
                    tabItem.badgeValue = "+99"
                } else {
                    tabItem.badgeValue = "\(count)"
                }
            }
        }
        
        presenter?.getProfileUser()
        callAPIPosition()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        btnReloadPage()
    }
    
    func getMenuNotLogin() {
        rowList.removeAll()
        rowList.append(.header)
        rowList.append(.historyCoin)
        rowList.append(.historyBuy)
        rowList.append(.policy)
        rowList.append(.tutorial)
        rowList.append(.setting)
        rowList.append(.version)
    }
    
    func getMenuLoggedIn() {
        rowList.removeAll()
        rowList.append(.header)
        rowList.append(.historyCoin)
        rowList.append(.historyBuy)
        rowList.append(.policy)
        rowList.append(.tutorial)
        rowList.append(.setting)
        rowList.append(.changePassword)
        rowList.append(.logout)
        rowList.append(.version)
    }
    
    func getMenuLoggedSocial() {
        rowList.removeAll()
        rowList.append(.header)
        rowList.append(.historyCoin)
        rowList.append(.historyBuy)
        rowList.append(.policy)
        rowList.append(.tutorial)
        rowList.append(.setting)
        rowList.append(.logout)
        rowList.append(.version)
    }
    
    func registerTableView(){
        tvMore.delegate = self
        tvMore.dataSource = self
        tvMore.registerXibFile(MoreHeaderCell.self)
        tvMore.registerXibFile(MoreCell.self)
        tvMore.tableFooterView = UIView()
        tvMore.separatorStyle = .none
    }
    
    func callAPIPosition() {
        Provider.shared.userAPIService.getGPSPosition(lat: UserDefaultHelper.shared.lat, long: UserDefaultHelper.shared.long, success: { (_) in
        }) { (_) in
        }
    }
    
    @objc func btnReloadPage() {
        if UserDefaultHelper.shared.loginSocial == "facebook" || UserDefaultHelper.shared.loginSocial == "google" {
            getMenuLoggedSocial()
            
        } else if UserDefaultHelper.shared.isLoggedIn {
            getMenuLoggedIn()
            
        } else {
            getMenuNotLogin()
        }
        
        tvMore.reloadData()
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = self.rowList[indexPath.item]
        
        if type == MoreEntityType.header {
            let cell = tableView.dequeue(MoreHeaderCell.self, for: indexPath)
            cell.setupView(user: self.user)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeue(MoreCell.self, for: indexPath)
            cell.showData(type: type)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = self.rowList[indexPath.item]
        presenter?.goToPage(name: type)
        if type == .version {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = self.rowList[indexPath.item]
        if type == .header {
            return 160
        }
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

extension MoreViewController: MoreViewProtocol {
    
    func didGetProfileUser(user: UserEntity?) {
        self.user = user
    }
    
    func logoutSuccess() {
//        getMenuNotLogin()
//        tvMore.reloadData()
//        DataManager.shared.getNotificationCount { (count) in
//            if let tabItems = self.tabBarController?.tabBar.items {
//                let tabItem = tabItems[3]
//                if count == 0 {
//                    tabItem.badgeValue = nil
//                } else {
//                    tabItem.badgeValue = "\(count)"
//                }
//            }
//        }
//
//        // come back to home page
//        self.tabBarController?.selectedIndex = 0
        
        AppRouter.shared.openTabbar()
    }
}
