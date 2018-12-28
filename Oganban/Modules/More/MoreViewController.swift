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
    var rowList: [MoreRowName] = [MoreRowName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleNavigation(title: NavigationTitle.more)
        self.registerTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getData()
        tvMore.reloadData()
    }
    
    func getData() {
        
        rowList.removeAll()
        
        rowList.append(.header)
        rowList.append(.historyCoin)
        rowList.append(.historyBuy)
        rowList.append(.policy)
        rowList.append(.tutorial)
        rowList.append(.setting)
        
        if UserDefaultHelper.shared.loginUserInfo != nil {
            rowList.append(.changePassword)
            rowList.append(.logout)
        }
        
        rowList.append(.logout)
    }
    func registerTableView(){
        tvMore.delegate = self
        tvMore.dataSource = self
        tvMore.registerXibFile(MoreHeaderCell.self)
        tvMore.registerXibFile(MoreCell.self)
        tvMore.tableFooterView = UIView()
        tvMore.separatorStyle = .none
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == MoreRowName.header.index() {
            let cell = tableView.dequeue(MoreHeaderCell.self, for: indexPath)
            cell.setupView()
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeue(MoreCell.self, for: indexPath)
            cell.showData(index: indexPath.row)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == MoreRowName.header.index() {
            presenter?.goToPage(name: .header)
            return
        }
        
        if indexPath.row == MoreRowName.historyCoin.index() {
            presenter?.goToPage(name: .historyCoin)
            return
        }
        
        if indexPath.row == MoreRowName.historyBuy.index() {
            presenter?.goToPage(name: .historyBuy)
            return
        }
        if indexPath.row == MoreRowName.policy.index() {
            presenter?.goToPage(name: .policy)
            return
        }
        if indexPath.row == MoreRowName.tutorial.index() {
            presenter?.goToPage(name: .tutorial)
            return
        }
        if indexPath.row == MoreRowName.setting.index(){
            presenter?.goToPage(name: .setting)
            return
        }
        
        if UserDefaultHelper.shared.loginUserInfo != nil {
            if indexPath.row == MoreRowName.changePassword.index(){
                presenter?.goToPage(name: .changePassword)
                return
            }
            if indexPath.row == MoreRowName.logout.index(){
//                presenter?.goToPage(name: .logout)
                presenter?.logout()
                return
            }
        }
        
        if indexPath.row == MoreRowName.version.index() {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == MoreRowName.header.index() {
            return 160
        }
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       return 0
    }
}

extension MoreViewController: MoreViewProtocol {
    func logoutSuccess() {
        tvMore.reloadData()
    }
}
