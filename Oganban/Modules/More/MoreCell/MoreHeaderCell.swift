//
//  MoreHeaderCell.swift
//  free
//
//  Created by Admin on 12/17/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class MoreHeaderCell: UITableViewCell {
    
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCoinTotal: UILabel!
    @IBOutlet weak var lbName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        showData()
    }
    
    func setupView() {
        ivAvatar.layer.cornerRadius = ivAvatar.frame.width / 2.0
        ivAvatar.layer.masksToBounds = true
    }
    
    func showData() {
        lbName.text = "Ly Nguyễn"
        lbPhone.text = "0946258000"
        
        let num: Double = 30005.12
        let numString = String(num)
        
        if let coin = numString.addComma() {
            lbCoinTotal.text = "Tổng ƠCoin tích luỹ: " + coin  + " ơ"
        }
    }
}

extension String {
    func addComma() -> String? {
        if self.isEmpty == false{
            let formater = NumberFormatter()
            formater.groupingSeparator = ","
            formater.numberStyle = .decimal
            if let num = formater.number(from: self){
                return formater.string(from: num)
            }
            else{
                return nil
            }
        }
        return nil
    }
    
    func getSubString(fromCharacter: String) -> String?{
        if let range = self.range(of: fromCharacter) {
            let subText = self[range.upperBound...]
            return String(subText)
        }
        return nil
    }
}
