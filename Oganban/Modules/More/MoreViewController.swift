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
                let vc = UpdateProfileRouter.createModule()
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case MoreRowName.historyCoin.index():
                let vc = LoginRouter.createModule()
                self.present(controller: vc, animated: true)
                print("Chọn Lịch sử ƠCoin")
                break
            case MoreRowName.historyBuy.index():
                PopUpHelper.shared.showDateFollowWeekPopup(completionDate: { (date) in
                    if let date = date {
                        print("SELECTED DATE: " + date.toString(dateFormat: AppDateFormat.ddMMYYYY_VN))
                    }
                })
                print("Chọn Lịch sử mua tin")
                break
            case MoreRowName.policy.index():
                PopUpHelper.shared.showUpdateQuantityBuy { (_) in
                    //
                }
                print("Chọn Điều khoản sử dụng")
                break
            case MoreRowName.tutorial.index():
                print("Chọn Hướng dẫn")
                break
            case MoreRowName.setting.index():
                print("Chọn Cài đặt")
                break
            case MoreRowName.changePassword.index():
                print("Chọn Đổi mật khẩu")
                break
            case MoreRowName.logout.index():
                print("Chọn Đăng xuất")
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
        return 4
    }
}
