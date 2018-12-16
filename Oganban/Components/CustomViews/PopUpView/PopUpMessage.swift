//
//  PopUpMessage.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class PopUpMessage: BasePopUpViewCenter {
    var completion: CompletionClosure?
    
    static let shared = PopUpMessage()
    
    let lbContent: UILabel = {
        let lb              = UILabel()
        lb.textColor        = .black
        lb.numberOfLines    = 0
        lb.textAlignment    = .center
        return lb
    }()
    
    lazy var btnOK: UIButton = {
        let btn             = UIButton()
        btn.backgroundColor = .clear
        btn.setAttributed(title: "OK", color: UIColor.red, font: AppFont.fontRegular17)
        btn.setBorder(cornerRadius: 20)
        btn.addTarget(self, action: #selector(btnOkTapped), for: .touchUpInside)
        return btn
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        self.vContent.addSubview(lbContent)
        self.vContent.addSubview(btnOK)
        self.vContent.addSubview(vLine)
        self.vContent.backgroundColor = .white
        
        lbContent.centerXToSuperview()
        
        lbContent.anchor(vContent.topAnchor,
                         left           : vContent.leftAnchor,
                         right          : vContent.rightAnchor,
                         topConstant    : 10,
                         leftConstant   : 10,
                         rightConstant  : 10)
        
        btnOK.anchor(lbContent.bottomAnchor,
                     left           : vContent.leftAnchor,
                     bottom         : vContent.bottomAnchor,
                     right          : vContent.rightAnchor,
                     topConstant    : 5,
                     leftConstant   : 10,
                     bottomConstant : 5,
                     rightConstant  : 10,
                     heightConstant : 35)
        vLine.anchor(btnOK.topAnchor, left: lbContent.leftAnchor, right: lbContent.rightAnchor, topConstant: 0, leftConstant: 0, rightConstant: 0, heightConstant: 1)
        btnOK.addTarget(self, action: #selector(btnOkTapped), for: .touchUpInside)
    }
    
    @objc func btnOkTapped() {
        self.hidePopUp()
        self.completion?()
    }
    
    func showPopUp(message: String, completion: CompletionClosure? = nil) {
        self.lbContent.text     = message
        self.completion         = completion
        showPopUp()
    }
    
    func showPopUp(message: String) {
        self.lbContent.text     = message
        showPopUp()
    }
    
    override func showPopUp() {
        super.showPopUp()
    }
}
