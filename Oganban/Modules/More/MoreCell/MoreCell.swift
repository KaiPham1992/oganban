//
//  MoreCell.swift
//  free
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

enum MoreRowName: String {
    case historyCoin
    case historyBuy
    case policy
    case tutorial
    case setting
    case changePassword
    case logout
    
    func index() -> Int {
        switch self {
        case .historyCoin:
            return 1
        case .historyBuy:
            return 2
        case .policy:
            return 3
        case .tutorial:
            return 4
        case .setting:
            return 5
        case .changePassword:
            return 6
        case .logout:
            return 7
        }
    }
    
}

class MoreCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(index: Int){
        switch index {
        case MoreRowName.historyCoin.index():
            lbTitle.text = "Lịch sử ƠCoin"
            break
        case MoreRowName.historyBuy.index():
            lbTitle.text = "Lịch sử mua tin"
            break
        case MoreRowName.policy.index():
            lbTitle.text = "Điều khoản sử dụng"
            break
        case MoreRowName.tutorial.index():
            lbTitle.text = "Hướng dẫn"
            break
        case MoreRowName.setting.index():
            lbTitle.text = "Cài đặt"
            break
        case MoreRowName.changePassword.index():
            lbTitle.text = "Đổi mật khẩu"
            break
        case MoreRowName.logout.index():
            lbTitle.text = "Đăng xuất"
            break
        default:
            break
        }
    }
}
