//
//  HistoryView.swift
//  RedStar
//
//  Created by Coby on 11/27/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class HistoryView: BaseViewXib {
    
    @IBOutlet weak var vShadow: UIView!
    @IBOutlet weak var vContent: UIView!
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTiltleName: UILabel!
    @IBOutlet weak var lbDayTime: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var vDelete: UIView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var isShowRemove: Bool = false
    
    var appointment: AppointmentEntity? {
        didSet {
            guard let _appointment = appointment else { return }
            lbNumber.text = "#\(_appointment.code ?? "123456")"
            lbStatus.text = "Chờ xác nhận"
            lbTiltleName.text = appointment?.projectName
            lbAddress.text = appointment?.address
            if let date = appointment?.timeBooking {
                lbDayTime.text = date.toString(formatString: AppDateFormat.ddMMyyyyhhmmma.formatString)
            } else {
                lbDayTime.text = "09:00 04-11-2018"
            }
            
            
        }
    }
    
    func showShadowBoder() {
        vShadow.setShadow(color: .black, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
        vContent.setBorder(borderWidth: 0.5, borderColor: AppColor.gray, cornerRadius: 5)
    }
    
    func hideShadowBoder() {
        vShadow.setShadow(color: UIColor.white, opacity: 0.5, offSet: CGSize(width: 5, height: -5), radius: 5, scale: true)
        vContent.setBorder(borderWidth: 0.5, borderColor: .white, cornerRadius: 5)
    }
    
    override func setUpViews() {
        
        imgAvatar.setBorder(borderWidth: 0.2, borderColor: AppColor.gray, cornerRadius: 10)
        vDelete.isHidden = true
    }
    
    func setShowRemove() {
        vDelete.isHidden = isShowRemove ? false : true
        lbStatus.isHidden = isShowRemove ? true : false
    }
}
