//
//  MoreViewController.swift
//  free
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController,MoreViewProtocol {
    
    var presenter: MorePresenterProtocol?

    @IBOutlet weak var tvMore: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerTableView()
    }

    func registerTableView(){
        tvMore.delegate = self
        tvMore.dataSource = self
        tvMore.register(UINib(nibName: "MoreHeaderCell", bundle: nil), forCellReuseIdentifier: "MoreHeaderCell")
        tvMore.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
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
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreHeaderCell", for: indexPath) as? MoreHeaderCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as? MoreCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.showData(index: indexPath.row)
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
        if indexPath.row == 0 {
            return 150
        }
        return 52
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
}
