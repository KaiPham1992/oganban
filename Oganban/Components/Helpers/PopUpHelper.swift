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
    
    func showMessageHaveAds(message: String) {
        let popUp = PopUpNotificationHaveAdmob()
        popUp.showPopUp(message: message)
    }
    
    func showYesNoQuestionHaveAds(question: String, completionYes: @escaping CompletionClosure, completionNo: @escaping CompletionClosure) {
        let popUp = PopUpYesNoHaveAdmob()
        popUp.showPopUp(question: question, completionYes: completionYes, completionNo: completionNo)
    }
    
    func showUpdateQuantityBuy(completionQuantity: @escaping CompletionMessage) {
        let popUp = PopUpUpdateQuantityBuy()
        popUp.showPopUp(completionQuantity: completionQuantity)
    }
    
    func showNoGPS() {
        let popUp = PopUpSettingGPS()
        popUp.showPopUp()
    }
    
}
