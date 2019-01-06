//
//  NotificationCell.swift
//  RedStar
//
//  Created by Ngoc Duong on 12/13/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class NotificationCell: BaseTableCell {
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var notification: NotificationEntity? {
        didSet {
            guard let _notification = notification else { return }
            if let date = _notification.createTime {
                lbDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYY_VNHHmm)
            }
            
            lbContent.text = _notification.content?.trim()
            if _notification.isRead == true  {
                self.backgroundColor = .white
            } else {
                self.backgroundColor = AppColor.pinkBackground
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
