//
//  BannerPopUpView.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/20/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit
import SDWebImage

class BannerPopUpView: BasePopUpViewCenter {
    
    let imgBanner: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let btnClose: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "clear"), for: .normal)
        btn.addTarget(self, action: #selector(btnCloseTapped), for: .touchUpInside)
        return btn
    }()
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(imgBanner)
        vBackground.addSubview(btnClose)
        layoutView()
    }
    
    func layoutView() {
//        imgBanner.fillSuperview()
        imgBanner.anchor(vBackground.topAnchor, left: vBackground.leftAnchor, bottom: vBackground.bottomAnchor, right: vBackground.rightAnchor, topConstant: 100, leftConstant: 20, bottomConstant: 100, rightConstant: 20)
        btnClose.anchor(vBackground.topAnchor, right: vBackground.rightAnchor, topConstant: 60, rightConstant: 20, widthConstant: 40, heightConstant: 40)
//        btnClose.anchor(bottom: vContent.topAnchor, right: vContent.rightAnchor, bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
    }
    
    func showPopUP(url: String) {
        let urlImage = "\(BASE_URL_IMAGE)\(url)"
        if let url  = URL(string: urlImage) {
            imgBanner.sd_setImage(with: url, placeholderImage: AppImage.imgDemoProject)
        }
        self.showPopUp()
    }
    
    @objc func btnCloseTapped() {
        self.hidePopUp()
    }
}
