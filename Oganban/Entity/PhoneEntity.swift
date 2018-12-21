//
//  PhoneEntity.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//
import Foundation

class PhoneEntity {
    var phoneNumber: String?
    var phoneCode: String?
    var phoneFullCodeAndNumber: String?
    
    init(phoneNumber: String?, phoneCode: String?) {
        self.phoneCode = phoneCode
        self.phoneNumber = phoneNumber
        
        self.phoneFullCodeAndNumber = "\(self.phoneCode&)\(self.phoneNumber&)"
    }
}
