//
//  PopUpLogout.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class PopUpLogout: BasePopUpViewCenter {
    
    var approveComplete: CompletionClosure?
    var cancelComplete: CompletionClosure?
    
    static let shared = PopUpLogout()
    
    lazy var vMargin: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var btnApproved: UIButton = {
        let btn             = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.setAttributed(title: "Có",
                          color: UIColor.red,
                          font: AppFont.fontRegular15)
        btn.addTarget(self, action: #selector(btnApprovedTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnCancel: UIButton = {
        let btn             = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.setAttributed(title: "Không",
                          color: UIColor.red,
                          font: AppFont.fontRegular15)
        btn.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Đăng xuất"
        lb.font = AppFont.fontBold17
        lb.textColor = UIColor.black
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var lbContent: UILabel = {
        let lb = UILabel()
        lb.text = "Bạn có chắc muốn đăng xuất khỏi tài khoản này không?"
        lb.numberOfLines = 0
        lb.font = AppFont.fontRegular15
        lb.textColor = UIColor.black
        lb.textAlignment = .left
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(vMargin)
        vMargin.addSubview(lbTitle)
        vMargin.addSubview(lbContent)
        vMargin.addSubview(btnCancel)
        vMargin.addSubview(btnApproved)
        setUpLayout()
    }
    
    func setUpLayout() {
        vMargin.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: vContent.bottomAnchor, right: vContent.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 5, rightConstant: 10)
        
        lbTitle.fillHorizontalSuperview()
        lbTitle.topAnchor.constraint(equalTo: vMargin.topAnchor).isActive = true
        
        lbContent.fillHorizontalSuperview()
        lbContent.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 5).isActive = true
        
        btnApproved.anchor(lbContent.bottomAnchor, bottom: vMargin.bottomAnchor, right: vMargin.rightAnchor, topConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 40)
        btnCancel.anchor(bottom: vMargin.bottomAnchor, right: btnApproved.leftAnchor, bottomConstant: 0, rightConstant: 10, widthConstant: 80, heightConstant: 40)
    }
    
    @objc func btnApprovedTapped() {
        self.hidePopUp()
        self.approveComplete?()
    }
    
    @objc func btnCancelTapped() {
        self.hidePopUp()
        self.cancelComplete?()
    }
    
    func showPopUp(title: String, content: String, approve: CompletionClosure? = nil, cancel: CompletionClosure? = nil) {
        lbTitle.text = title
        lbContent.text = content
        self.approveComplete = approve
        self.cancelComplete = cancel
        super.showPopUp()
    }
    
    func showPopUp(btnCancel: String,btnAccept: String, title: String, content: String, approve: CompletionClosure? = nil, cancel: CompletionClosure? = nil) {
        lbTitle.text = title
        lbContent.text = content
        btnApproved.setAttributed(title: btnAccept,
                                  color: UIColor.red,
                                  font: AppFont.fontRegular15)
        self.btnCancel.setAttributed(title: btnCancel,
                                     color: UIColor.red,
                                     font: AppFont.fontRegular15)
        self.approveComplete = approve
        self.cancelComplete = cancel
        super.showPopUp()
    }
    
    func showPopUp(approve: CompletionClosure? = nil, cancel: CompletionClosure? = nil) {
        self.approveComplete = approve
        self.cancelComplete = cancel
        super.showPopUp()
    }
}


