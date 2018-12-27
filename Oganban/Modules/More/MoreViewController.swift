//
//  MoreViewController.swift
//  free
//
//  Created by Kent on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController, MoreViewProtocol {
    
    var presenter: MorePresenterProtocol?
    
    @IBOutlet weak var tvMore: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTitleNavigation(title: NavigationTitle.more)
        self.registerTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tvMore.reloadData()
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
        return MoreRowName.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == MoreRowName.header.index() {
            let cell = tableView.dequeue(MoreHeaderCell.self, for: indexPath)
            cell.setupView()
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeue(MoreCell.self, for: indexPath)
            cell.showData(index: indexPath.row)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case MoreRowName.header.index():
            presenter?.goToPage(name: .header)
            break
        case MoreRowName.historyCoin.index():
            presenter?.goToPage(name: .historyCoin)
            break
        case MoreRowName.historyBuy.index():
            presenter?.goToPage(name: .historyBuy)
            break
        case MoreRowName.policy.index():
            presenter?.goToPage(name: .policy)
            break
        case MoreRowName.tutorial.index():
            presenter?.goToPage(name: .tutorial)
            break
        case MoreRowName.setting.index():
            presenter?.goToPage(name: .setting)
            break
        case MoreRowName.changePassword.index():
            presenter?.goToPage(name: .changePassword)
            break
        case MoreRowName.logout.index():
            if UserDefaultHelper.shared.loginUserInfo != nil {
                presenter?.goToPage(name: .logout)
            } 
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == MoreRowName.header.index() {
            return 160
        }
        return 52
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
       if UserDefaultHelper.shared.loginUserInfo == nil {

        return 0
        }
        return 4
    }
}
