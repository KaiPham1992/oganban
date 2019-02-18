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
    
    let linkShare = "http://onelink.to/k77kce"
    
    func showShare(controller: UIViewController, items: [String]) {
        var share = ""
        if !items.isEmpty {
            share = "\(items[0])\n\(linkShare)"
        } else {
            share = "\(linkShare)"
        }
        let activityController = UIActivityViewController(activityItems: [share], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = controller.view
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completion")
            } else {
                print(error.debugDescription&)
            }
        }
        controller.present(controller: activityController)
    }
    
    func showShareLinkInstall(controller: UIViewController) {
        showShare(controller: controller, items: [])
    }
}
