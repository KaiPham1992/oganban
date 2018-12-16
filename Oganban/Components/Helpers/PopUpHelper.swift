//
//  PopUpHelper.swift
//  RedStar
//
//  Created by DINH VAN TIEN on 11/20/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit

class PopUpHelper {
    static let shared = PopUpHelper()
    
    func showPopUpBanner(url: String) {
        DispatchQueue.main.async {
            let popUp = BannerPopUpView()
            popUp.showPopUP(url: url)
        }
        
    }
    
    func showPopUpMessage(title: String = "") {
        DispatchQueue.main.async {
            let popUp = PopUpMessage()
            popUp.showPopUp(message: title)
        }
    }
    
    func showPopUpMessage(title: String = "", action: CompletionClosure? = nil) {
        DispatchQueue.main.async {
            let popUp = PopUpMessage()
            popUp.showPopUp(message: title, completion: action)
        }
    }
    
    func showPopUp(title: String, content: String, approve: CompletionClosure? = nil, cancel: CompletionClosure? = nil) {
        DispatchQueue.main.async {
            let popUp = PopUpLogout()
            popUp.showPopUp(title: title, content: content, approve: approve, cancel: cancel)
        }
    }
}
