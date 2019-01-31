//
//  AppTextFieldDisable.swift
//  Oganban
//
//  Created by Coby on 2/1/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class AppTextFieldDisable: UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
    }
}
