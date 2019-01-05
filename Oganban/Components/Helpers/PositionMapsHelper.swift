//
//  PositionMapsHelper.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class PositionMapsHelper: NSObject {
    static let shared = PositionMapsHelper()
    var controller: UIViewController?
    var completion: CompletionMessage?
}

extension PositionMapsHelper: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.completion?(place.formattedAddress)
        controller?.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
       
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        controller?.dismiss(animated: true, completion: nil)
    }
    
    func showSearch(controller: UIViewController?, completion: CompletionMessage?) {
        self.completion = completion
        self.controller = controller
        let acController = GMSAutocompleteViewController()
        acController.navigationController?.navigationBar.barTintColor = AppColor.red_110_0_0
        acController.delegate = self
        
        controller?.present(acController, animated: true, completion: nil)
    }
}
