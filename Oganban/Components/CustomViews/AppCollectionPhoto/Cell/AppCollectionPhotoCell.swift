//
//  AppCollectionPhotoCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

//AppCollectionPhotoCell


import UIKit
import SDWebImage

class AppCollectionPhotoCell: BaseCollectionCell {
    let imgPhoto: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    let imgClose: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = AppImage.imgClose
        
        return img
    }()
    
    let btnRemove : UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    
    var photo: AppPhoto? {
        didSet {
            loadImage(photo: photo)
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        //--
        addSubview(imgPhoto)
        addSubview(imgClose)
        addSubview(btnRemove)
        
        //--
        imgPhoto.fillSuperview()
        imgClose.anchor(topAnchor, right: rightAnchor, topConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)
        btnRemove.fillToView(view: imgClose)
    }
    
    func loadImage(photo: AppPhoto?) {
        guard let _photo = photo else { return }
        
        switch _photo.status {
        case .new:
            imgPhoto.image = AppImage.imgUploadPhoto
        case .uploaded:
            if let image = _photo.image {
                imgPhoto.image = image
            } else if let url = URL(string: _photo.url&) {
                imgPhoto.sd_setImage(with: url, placeholderImage: AppImage.imgUploadPhoto)
            } else {
                 imgPhoto.image = AppImage.imgErrorUpLoadPhoto
            }
            
        case .error:
            imgPhoto.image = AppImage.imgErrorUpLoadPhoto
        }
    }
}