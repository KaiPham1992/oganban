//
//  Post+Valid.swift
//  Oganban
//
//  Created by Kai Pham on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

extension PostStepOneViewController {
    // FIX ME
    func validInput() -> Bool {
        if category == nil {
            errorMessage = "Chọn danh mục để đăng tin"
            return false
        }
        
        if vPhoto.listImage.count < 5 {
            errorMessage = "Chọn ít nhất 5 hình"
            return false
        }
        
        if vTitleRecord.textField.text& == "" {
            errorMessage = "Nhập tiêu đề đăng tin"
            return false
        }
        
        if self.dateSeleted == nil {
            errorMessage = "Chọn thời hạn đăng bán"
            return false
        }
        
        if vAbout.tvInput.text& == "" {
            errorMessage = "Nhập giới thiệu sản phẩm"
            return false
        }
        
        return true
    }
}
