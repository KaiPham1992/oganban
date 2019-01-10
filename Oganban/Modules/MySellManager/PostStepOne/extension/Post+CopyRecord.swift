//
//  Post+CopyRecord.swift
//  Oganban
//
//  Created by Ngoc Duong on 1/8/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

extension PostStepOneViewController {
    
    func setupUpdate() {
        lbCategory.text = record?.categoryName
        vTitleRecord.textField.text = record?.name
        vQuantity.textField.text = "\(record?.quantity ?? 0)"
        vChooseDate.textField.text = record?.createTime?.toString(dateFormat: AppDateFormat.ddMMMyyyy)
        vAbout.tvInput.text = record?.about
        vAbout.lbPlaceHolder.text = ""
    
        guard let arrayImage = record?.arrayImage else { return }
        let listImage = arrayImage.map({ (string) -> AppPhoto in
            return AppPhoto(status: AppPhotoStatus.uploaded, image: nil, url: string)
        })
        vPhoto.listImage = listImage
    }
}

