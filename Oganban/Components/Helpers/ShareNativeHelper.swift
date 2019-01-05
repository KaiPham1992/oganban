//
//  ShareNativeHelper.swift
//  Oganban
//
//  Created by Kai Pham on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import UIKit

class ShareNativeHelper: NSObject {
    static let shared = ShareNativeHelper()
    
    func showShare(controller: UIViewController, items: [Any]) {
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completion")
            } else {
                print(error.debugDescription&)
            }
        }
        controller.present(controller: activityController)
    }
}
